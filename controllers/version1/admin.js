// MODELS
const Role = require("../../models/role");
const Administrator = require("../../models/admin");

// VALIDATIONS
const { adminValidation } = require("../../validations/admin");

// UTILITIES
const DateUtil = require("../../utilities/date_utility");
const { login } = require("../../utilities/login_utility");
const Response = require("../../utilities/response_utility");
const unique = require("../../utilities/codegenerator_utility");
const ResponseMessage = require("../../utilities/messages_utility");
const PaginationUtility = require("../../utilities/pagination_utility");
const { resetPassword } = require("../../utilities/resetpassword_utility");
const { changePassword } = require("../../utilities/changepassword_utility");
const { createActivityLog } = require("../../utilities/activitylog_utility");

const moduleName = `Administrator`;

module.exports = {
  create: async (req, res) => {
    try {
      const body = req.body;
      const { error } = adminValidation(body);

      if (error) {
        return Response.sendValidationErrorMessage(res, 400, error);
      }

      const existingUser = await Administrator.findOne({
        email: body.username,
        name: body.name,
      });

      if (existingUser) {
        return Response.customResponse(res, 409, ResponseMessage.DATA_EXISTS);
      }

      const role = await Role.findById(body.roleId);

      if (!role) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      // const phone = new Phone({});
      // phone.code = body.phone.code;
      // phone.number = body.phone.number;

      const uniqueCode = unique.randomCode();
      const hashedPassword = unique.passwordHash(body.password);

      const user = new Administrator({
        code: "AD" + uniqueCode,
        name: body.name,
        roleId: body.roleId,
        status: body.status,
        // phone: phone,
        avatar: body.avatar,
        email: body.username,
        password: hashedPassword,
        createdAt: DateUtil.currentDate(),
      });

      const newUser = await user.save();

      const action = `New ${moduleName} - ${"AD" + uniqueCode}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(newUser);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  getUsers: async (req, res) => {
    try {
      const totalUsers = await Administrator.countDocuments();
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalUsers
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      pagination.data = await Administrator.find()
        // .populate([{ path: "role", select: "name claims" }])
        .populate({ path: "role", select: "name claims" })
        .select("-password")
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalUsers === 0) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.NO_DATA
        );
      }

      pagination.data = pagination.data.map((item) => ({
        ...item.toJSON(),
        role: item.role ? item.role.name : null,
        permissions: item.role ? item.role.claims : null,
      }));

      return Response.paginationResponse(res, res.statusCode, pagination);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  getUsersByRole: async (req, res) => {
    try {
      const role = await Role.findById(req.params.id);

      if (!role) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const roleId = role._id;
      const totalUsers = await Administrator.countDocuments({ roleId: roleId });
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalUsers
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      pagination.data = await Administrator.find({ roleId: roleId })
        // .populate([{ path: "role", select: "name claims" }])
        .populate({ path: "role", select: "name claims" })
        .select("-password")
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalUsers === 0) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.NO_DATA
        );
      }

      pagination.data = pagination.data.map((item) => ({
        ...item.toJSON(),
        role: item.role ? item.role.name : null,
        permissions: item.role ? item.role.claims : null,
      }));

      return Response.paginationResponse(res, res.statusCode, pagination);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  get: async (req, res) => {
    try {
      const user = await Administrator.findById(req.params.id)
        .select("-password")
        .populate([
          {
            path: "role",
            select: "name claims",
          },
        ]);

      if (!user) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const userData = {
        code: user.code,
        fullname: user.fullName,
        username: user.username,
        avatar: user.avatar,
        status: user.status,
        createdAt: user.createdAt,
        id: user._id,
        role: user.role ? user.role.name : null,
        permissions: user.role ? user.role.claims : null,
      };

      return Response.successResponse(res, res.statusCode, userData);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  update: async (req, res) => {
    try {
      const body = req.body;
      const user = await Administrator.findById(body.id);

      if (!user) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      user.name = body.name || user.name;
      user.avatar = body.avatar || user.avatar;
      user.roleId = body.roleId || user.roleId;
      user.status = body.status;
      user.actionBy = body.userId || user.actionBy;
      user.email = body.username || user.email;
      user.updatedAt = DateUtil.currentDate();

      const updatedUser = await user.save();

      const action = `Updated ${moduleName} - ${user.code}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(updatedUser);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  delete: async (req, res) => {
    try {
      const param = req.params;
      const userId = param.userId;

      const user = await Administrator.findById(param.id);

      if (!user) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      await user.deleteOne();

      const action = `Deleted ${moduleName} - ${user.code}`;
      await createActivityLog(moduleName, action, userId);

      return res.status(res.statusCode).json({
        message: ResponseMessage.SUCCESS_MESSAGE,
      });
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  changePassword: async (req, res) => {
    await changePassword(req, res, Administrator, moduleName);
  },

  resetPassword: async (req, res) => {
    await resetPassword(req, res, Administrator, moduleName);
  },

  login: async (req, res) => {
    await login(req, res, Administrator);
  },
};

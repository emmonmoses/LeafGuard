const express = require("express");
const router = express.Router();
const version = process.env.API_VERSION;

// Importing route handlers for different endpoints
const roleRouter = require("./version1/role");
const permissionRouter = require("./version1/permission");
const treeReceptionRouter = require("./version1/treereception");
const individualRouter = require("./version1/individual");
const organisationRouter = require("./version1/organisation");
const monitoringScheduleRouter = require("./version1/monitoringSchedule"); 
const plantingScheduleRouter = require("./version1/plantingSchedule"); 
const statusRouter = require("./version1/status"); 
const treeTypeRouter = require("./version1/treeTypes");
const monitorRouter = require("./version1/monitor");
const userRouter = require("./version1/admin");

router.use(`/v${version}/roles`, roleRouter);
router.use(`/v${version}/permissions`, permissionRouter);
router.use(`/v${version}/treereceptions`, treeReceptionRouter);
router.use(`/v${version}/individuals`, individualRouter);
router.use(`/v${version}/organisations`, organisationRouter);
router.use(`/v${version}/monitoringschedules`, monitoringScheduleRouter);
router.use(`/v${version}/plantingschedules`, plantingScheduleRouter);
router.use(`/v${version}/status`, statusRouter);
router.use(`/v${version}/treetypes`, treeTypeRouter);
router.use(`/v${version}/monitors`, monitorRouter);
router.use(`/v${version}/users`, userRouter);

module.exports = router;
// ignore_for_file: file_names

class DayOfWeek {
  String? day;
  bool availability;
  bool isExpanded;

  DayOfWeek({
    this.day,
    this.availability = false,
    this.isExpanded = true,
  });
}

List<DayOfWeek> daysofWeek = [
  DayOfWeek(
    day: 'Monday',
    availability: false,
  ),
  DayOfWeek(
    day: 'Tuesday',
    availability: false,
  ),
  DayOfWeek(
    day: 'Wednesday',
    availability: false,
  ),
  DayOfWeek(
    day: 'Thursday',
    availability: false,
  ),
  DayOfWeek(
    day: 'Friday',
    availability: false,
  ),
  DayOfWeek(
    day: 'Saturday',
    availability: false,
  ),
  DayOfWeek(
    day: 'Sunday',
    availability: false,
  ),
];

import 'package:simplane_client_admin/model/annual_report.dart';
import 'package:simplane_client_admin/model/passenger.dart';

import 'model/airport.dart';
import 'model/flight.dart';
import 'model/monthly_report.dart';
import 'model/ticket.dart';
import 'model/ticket_class.dart';
import 'model/user.dart';

final fakeDelay = Future.delayed(const Duration(milliseconds: 500));

const userDummy = User('123', 'nam1952001', 'Đặng Phương Nam', true, '');

final allFlightsDummy = [
  // Flight(
  //     id: 1,
  //     code: 'VN32134',
  //     fromAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
  //     toAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
  //     datetime: DateTime(2022, 4, 12),
  //     duration: 60,
  //     seatAmount: const {
  //       'E': 80,
  //       'B': 20
  //     },
  //     bookedAmount: const {
  //       'E': 56,
  //       'B': 10
  //     },
  //     middleAirports: const [
  //       Airport('HUI', 'Hue', 'Viet Nam'),
  //       Airport('HAN', 'Ha Noi', 'Viet Nam'),
  //     ],
  //     stopDurations: const [
  //       10,
  //       15,
  //     ]),
  // Flight(
  //     id: 2,
  //     code: 'VN56456',
  //     fromAirport: const Airport('HUI', 'Hue', 'Viet Nam'),
  //     toAirport: const Airport('HAN', 'Ha Noi', 'Viet Nam'),
  //     datetime: DateTime(2022, 5, 1),
  //     duration: 80,
  //     seatAmount: const {
  //       'E': 80,
  //       'B': 20
  //     },
  //     bookedAmount: const {
  //       'E': 56,
  //       'B': 10
  //     },
  //     middleAirports: const [
  //       Airport('SGN', 'TPHCM', 'Viet Nam'),
  //     ],
  //     stopDurations: const [
  //       12,
  //     ]),
  // Flight(
  //     id: 3,
  //     code: 'VN76745',
  //     fromAirport: const Airport('HAN', 'Ha Noi', 'Viet Nam'),
  //     toAirport: const Airport('HUI', 'Hue', 'Viet Nam'),
  //     datetime: DateTime(2022, 6, 10),
  //     duration: 60,
  //     seatAmount: const {'E': 80, 'B': 20},
  //     bookedAmount: const {'E': 56, 'B': 10},
  //     middleAirports: const [],
  //     stopDurations: const []),
  // Flight(
  //     id: 4,
  //     code: 'VN86786',
  //     fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
  //     toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
  //     datetime: DateTime(2022, 6, 11),
  //     duration: 60,
  //     seatAmount: const {'E': 80, 'B': 20},
  //     bookedAmount: const {'E': 56, 'B': 10},
  //     middleAirports: const [],
  //     stopDurations: const []),
  // Flight(
  //     id: 4,
  //     code: 'VN86786',
  //     fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
  //     toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
  //     datetime: DateTime(2022, 6, 11),
  //     duration: 60,
  //     seatAmount: const {'E': 80, 'B': 20},
  //     bookedAmount: const {'E': 56, 'B': 10},
  //     middleAirports: const [],
  //     stopDurations: const []),
  // Flight(
  //     id: 4,
  //     code: 'VN86786',
  //     fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
  //     toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
  //     datetime: DateTime(2022, 6, 11),
  //     duration: 60,
  //     seatAmount: const {'E': 80, 'B': 20},
  //     bookedAmount: const {'E': 56, 'B': 10},
  //     middleAirports: const [],
  //     stopDurations: const []),
  // Flight(
  //     id: 4,
  //     code: 'VN86786',
  //     fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
  //     toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
  //     datetime: DateTime(2022, 6, 11),
  //     duration: 60,
  //     seatAmount: const {'E': 80, 'B': 20},
  //     bookedAmount: const {'E': 56, 'B': 10},
  //     middleAirports: const [],
  //     stopDurations: const []),
  // Flight(
  //     id: 4,
  //     code: 'VN86786',
  //     fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
  //     toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
  //     datetime: DateTime(2022, 6, 11),
  //     duration: 60,
  //     seatAmount: const {'E': 80, 'B': 20},
  //     bookedAmount: const {'E': 56, 'B': 10},
  //     middleAirports: const [],
  //     stopDurations: const []),
  // Flight(
  //     id: 4,
  //     code: 'VN86786',
  //     fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
  //     toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
  //     datetime: DateTime(2022, 6, 11),
  //     duration: 60,
  //     seatAmount: const {'E': 80, 'B': 20},
  //     bookedAmount: const {'E': 56, 'B': 10},
  //     middleAirports: const [],
  //     stopDurations: const []),
  // Flight(
  //     id: 4,
  //     code: 'VN86786',
  //     fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
  //     toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
  //     datetime: DateTime(2022, 6, 11),
  //     duration: 60,
  //     seatAmount: const {'E': 80, 'B': 20},
  //     bookedAmount: const {'E': 56, 'B': 10},
  //     middleAirports: const [],
  //     stopDurations: const []),
];

final allTicketsDummy = [
  Ticket(
    id: 1,
    code: 'AF7D87ASF',
    flightCode: 'VN86786',
    passenger: const Passenger(
        id: 1,
        firstName: 'Dang',
        lastName: 'Nam',
        identityNumber: '1232131232',
        email: 'pnam@gmail.com',
        phoneNumber: '0832383974'),
    ticketClassId: 'B',
    price: 3000000,
    flightDate: DateTime(2022, 6, 11),
    bookedTime: DateTime(2022, 5, 16, 17, 4, 23),
    approvedTime: DateTime(2022, 5, 16, 17, 5, 23),
  ),
  Ticket(
    id: 2,
    code: 'H3JH435J5',
    flightCode: 'VN86324',
    passenger: const Passenger(
        id: 1,
        firstName: 'Trung',
        lastName: 'Truc',
        identityNumber: '42343423523',
        email: 'tt@gmail.com',
        phoneNumber: '0832327974'),
    ticketClassId: 'E',
    price: 450000,
    flightDate: DateTime(2022, 5, 22),
    bookedTime: DateTime(2022, 5, 16, 17, 4, 23),
    approvedTime: DateTime(2022, 5, 16, 17, 5, 23),
  ),
  Ticket(
    id: 3,
    code: 'H3JH4345H',
    flightCode: 'VN86327',
    passenger: const Passenger(
        id: 1,
        firstName: 'Hoang Thao',
        lastName: 'Linh',
        identityNumber: '43847234897',
        email: 'htl@gmail.com',
        phoneNumber: '0832321174'),
    ticketClassId: 'E',
    price: 900000,
    flightDate: DateTime(2022, 5, 22),
    bookedTime: DateTime(2022, 5, 16, 17, 4, 23),
   
  ),
  Ticket(
    id: 4,
    code: 'DASD2FD73',
    flightCode: 'VN86324',
    ticketClassId: 'E',
    price: 450000,
    flightDate: DateTime(2022, 5, 20),
  ),
  Ticket(
    id: 5,
    code: 'DA43JHD73',
    flightCode: 'VN86325',
    ticketClassId: 'B',
    price: 2000000,
    flightDate: DateTime(2022, 5, 22),
  ),
];

const reportsDummy = [
  AnnualReport(
    2022,
    [
      MonthlyReport(
          month: 1,
          year: 2022,
          ticketCount: 39,
          revenue: 2440000,
          staffId: 123),
      MonthlyReport(
          month: 2,
          year: 2022,
          ticketCount: 12,
          revenue: 1500000,
          staffId: 123),
      MonthlyReport(
          month: 3, year: 2022, ticketCount: 4, revenue: 1200000, staffId: 123),
      MonthlyReport(
          month: 4,
          year: 2022,
          ticketCount: 5,
          revenue: 14200000,
          staffId: 123),
      MonthlyReport(
          month: 5,
          year: 2022,
          ticketCount: 43,
          revenue: 3200000,
          staffId: 123),
      MonthlyReport(
          month: 6,
          year: 2022,
          ticketCount: 23,
          revenue: 2320000,
          staffId: 123),
      MonthlyReport(
          month: 7,
          year: 2022,
          ticketCount: 17,
          revenue: 8760000,
          staffId: 123),
      MonthlyReport(
          month: 8, year: 2022, ticketCount: 8, revenue: 2300000, staffId: 123),
      MonthlyReport(
          month: 9,
          year: 2022,
          ticketCount: 37,
          revenue: 2400000,
          staffId: 123),
      MonthlyReport(
          month: 10,
          year: 2022,
          ticketCount: 23,
          revenue: 244000,
          staffId: 123),
      MonthlyReport(
          month: 11,
          year: 2022,
          ticketCount: 35,
          revenue: 244000,
          staffId: 123),
      MonthlyReport(
          month: 12,
          year: 2022,
          ticketCount: 13,
          revenue: 244000,
          staffId: 123),
    ],
    123,
  ),
  AnnualReport(
    2021,
    [
      MonthlyReport(
          month: 1,
          year: 2021,
          ticketCount: 23,
          revenue: 2440000,
          staffId: 123),
      MonthlyReport(
          month: 2,
          year: 2021,
          ticketCount: 12,
          revenue: 1500000,
          staffId: 123),
      MonthlyReport(
          month: 3,
          year: 2021,
          ticketCount: 45,
          revenue: 1200000,
          staffId: 123),
      MonthlyReport(
          month: 4,
          year: 2021,
          ticketCount: 23,
          revenue: 1420000,
          staffId: 123),
      MonthlyReport(
          month: 5,
          year: 2021,
          ticketCount: 12,
          revenue: 3200000,
          staffId: 123),
      MonthlyReport(
          month: 6,
          year: 2021,
          ticketCount: 33,
          revenue: 2320000,
          staffId: 123),
      MonthlyReport(
          month: 7,
          year: 2021,
          ticketCount: 17,
          revenue: 8760000,
          staffId: 123),
      MonthlyReport(
          month: 8, year: 2021, ticketCount: 8, revenue: 2300000, staffId: 123),
      MonthlyReport(
          month: 9,
          year: 2021,
          ticketCount: 37,
          revenue: 2400000,
          staffId: 123),
      MonthlyReport(
          month: 10,
          year: 2021,
          ticketCount: 23,
          revenue: 244000,
          staffId: 123),
      MonthlyReport(
          month: 11,
          year: 2021,
          ticketCount: 35,
          revenue: 244000,
          staffId: 123),
      MonthlyReport(
          month: 12,
          year: 2021,
          ticketCount: 13,
          revenue: 244000,
          staffId: 123),
    ],
    123,
  ),
];

final ticketClassesDummy = [
  const TicketClass(
      'P', 'Super lite', 'Phổ thông siêu tiết kiệm', false, 0, false, 0),
  const TicketClass('L', 'Economy', 'Phổ thông', true, 120000.0, true, 0.0),
  const TicketClass('C', 'Business', 'Thương gia', true, 0, true, 30000.0),
];

import 'package:simplane_client_admin/model/passenger.dart';

import 'model/airport.dart';
import 'model/flight.dart';
import 'model/ticket.dart';
import 'model/user.dart';

final fakeDelay = Future.delayed(const Duration(milliseconds: 500));

const userDummy = User(123, 'nam1952001', 'Đặng Phương Nam', true, '');

final allFlightsDummy = [
  Flight(
      id: 1,
      code: 'VN32134',
      fromAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
      toAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
      datetime: DateTime(2022, 4, 12),
      duration: 60,
      seatAmount: const {
        'E': 80,
        'B': 20
      },
      bookedAmount: const {
        'E': 56,
        'B': 10
      },
      middleAirports: const [
        Airport('HUI', 'Hue', 'Viet Nam'),
        Airport('HAN', 'Ha Noi', 'Viet Nam'),
      ],
      stopDurations: const [
        10,
        15,
      ]),
  Flight(
      id: 2,
      code: 'VN56456',
      fromAirport: const Airport('HUI', 'Hue', 'Viet Nam'),
      toAirport: const Airport('HAN', 'Ha Noi', 'Viet Nam'),
      datetime: DateTime(2022, 5, 1),
      duration: 80,
      seatAmount: const {
        'E': 80,
        'B': 20
      },
      bookedAmount: const {
        'E': 56,
        'B': 10
      },
      middleAirports: const [
        Airport('SGN', 'TPHCM', 'Viet Nam'),
      ],
      stopDurations: const [
        12,
      ]),
  Flight(
      id: 3,
      code: 'VN76745',
      fromAirport: const Airport('HAN', 'Ha Noi', 'Viet Nam'),
      toAirport: const Airport('HUI', 'Hue', 'Viet Nam'),
      datetime: DateTime(2022, 6, 10),
      duration: 60,
      seatAmount: const {'E': 80, 'B': 20},
      bookedAmount: const {'E': 56, 'B': 10},
      middleAirports: const [],
      stopDurations: const []),
  Flight(
      id: 4,
      code: 'VN86786',
      fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
      toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
      datetime: DateTime(2022, 6, 11),
      duration: 60,
      seatAmount: const {'E': 80, 'B': 20},
      bookedAmount: const {'E': 56, 'B': 10},
      middleAirports: const [],
      stopDurations: const []),
  Flight(
      id: 4,
      code: 'VN86786',
      fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
      toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
      datetime: DateTime(2022, 6, 11),
      duration: 60,
      seatAmount: const {'E': 80, 'B': 20},
      bookedAmount: const {'E': 56, 'B': 10},
      middleAirports: const [],
      stopDurations: const []),
  Flight(
      id: 4,
      code: 'VN86786',
      fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
      toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
      datetime: DateTime(2022, 6, 11),
      duration: 60,
      seatAmount: const {'E': 80, 'B': 20},
      bookedAmount: const {'E': 56, 'B': 10},
      middleAirports: const [],
      stopDurations: const []),
  Flight(
      id: 4,
      code: 'VN86786',
      fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
      toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
      datetime: DateTime(2022, 6, 11),
      duration: 60,
      seatAmount: const {'E': 80, 'B': 20},
      bookedAmount: const {'E': 56, 'B': 10},
      middleAirports: const [],
      stopDurations: const []),
  Flight(
      id: 4,
      code: 'VN86786',
      fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
      toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
      datetime: DateTime(2022, 6, 11),
      duration: 60,
      seatAmount: const {'E': 80, 'B': 20},
      bookedAmount: const {'E': 56, 'B': 10},
      middleAirports: const [],
      stopDurations: const []),
  Flight(
      id: 4,
      code: 'VN86786',
      fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
      toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
      datetime: DateTime(2022, 6, 11),
      duration: 60,
      seatAmount: const {'E': 80, 'B': 20},
      bookedAmount: const {'E': 56, 'B': 10},
      middleAirports: const [],
      stopDurations: const []),
  Flight(
      id: 4,
      code: 'VN86786',
      fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
      toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
      datetime: DateTime(2022, 6, 11),
      duration: 60,
      seatAmount: const {'E': 80, 'B': 20},
      bookedAmount: const {'E': 56, 'B': 10},
      middleAirports: const [],
      stopDurations: const []),
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
    ticketClassId: 'E',
    price: 3000000,
    flightDate: DateTime(2022, 6, 11),
    bookedTime: DateTime(2022, 5, 16, 17, 4, 23),
  ),
];

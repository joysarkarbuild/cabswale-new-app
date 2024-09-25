import 'package:cabswalle/modules/home/data/models/lead_model.dart';

LeadsModel lead = LeadsModel(
  createdAt: DateTime.now(),
  shareImage: "https://example.com/image.png",
  active: true,
  createdBy: CreatedBy(
    id: "123",
    name: "John Doe",
    phoneNo: "+1123456789",
    verified: true,
    city: "New York",
    connections: 10,
    fraud: false,
    profileImage:
        "https://media.istockphoto.com/id/1386036075/photo/smiling-businessman-driving-his-car.jpg?s=612x612&w=0&k=20&c=ZtK7LH5WycXTkJeynWeT7hvzj7Z-V9MdcZAMr2WkALw=",
  ),
  from: From(city: "New York"),
  to: From(city: "Los Angeles"),
  carType: "SUV",
  message: "I need a car from New York to Los Angeles.\n good can \n call now",
  status: "Pending",
  metaData: {"key": "value"},
  leadType: "commission",
  otp: 123456,
);

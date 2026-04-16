class AttendeePreview {
  final String userId;
  final String username;
  final String avatarUrl;

  const AttendeePreview({
    required this.userId,
    required this.username,
    required this.avatarUrl,
  });

  factory AttendeePreview.fromJson(Map<String, dynamic> j) => AttendeePreview(
      userId:       j['userId']?.toString() ?? '',
      username:     j['username']   ?? '', 
      avatarUrl:    j['avatarUrl']  ?? '',
    );
}

class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String city;
  final String address;
  final List<String> genres;
  final String coverImageUrl;
  final bool isFree;
  final double? price;
  final int capacityMin;
  final int? capacityMax;
  final int attendeeCount;
  final bool isAttending;
  final List<AttendeePreview> mutualAttendees;
  final int mutualAttendeesCount;
  final double? distance;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.city,
    required this.address,
    required this.genres,
    required this.coverImageUrl,
    required this.isFree,
    this.price,
    required this.capacityMin,
    this.capacityMax,
    required this.attendeeCount,
    required this.isAttending,
    required this.mutualAttendees,
    required this.mutualAttendeesCount,
    this.distance,
  });

  factory EventModel.fromJson(Map<String, dynamic> j) => EventModel(
    id:                         j['id']?.toString() ?? '',
    title:                      j['title']        ?? '',
    description:                j['description']  ?? '',
    date:                       DateTime.parse(j['date']), 
    city:                       j['city']         ?? '', 
    address:                    j['address']      ?? '',
    genres:                     List<String>.from(j['genres'] ?? []), 
    coverImageUrl:              j['coverImageUrl'] ?? '', 
    isFree:                     j['isFree'] ?? true,
    price:                      (j['price'] as num?)?.toDouble(),
    capacityMin:                j['capacityMin'] ?? 0, 
    capacityMax:                j['capacityMax'],
    attendeeCount:              j['attendeeCount'] ?? 0, 
    isAttending:                j['isAttending'] ?? false, 
    mutualAttendees:            (j['mutualAttendees'] as List<dynamic>? ?? [])
        .map((a) => AttendeePreview.fromJson(a))
        .toList(),
    mutualAttendeesCount:       j['mutualAttendeesCount'] ?? 0,
    distance:                   (j['distance'] as num?)?.toDouble(),   
  );


  EventModel copyWith({bool? isAttending, int? attendeeCount}) => EventModel(
    id:                     id, 
    title:                  title, 
    description:            description, 
    date:                   date, 
    city:                   city, 
    address:                address, 
    genres:                 genres, 
    coverImageUrl:          coverImageUrl, 
    isFree:                 isFree,
    price:                  price, 
    capacityMin:            capacityMin, 
    attendeeCount:          attendeeCount ?? this.attendeeCount, 
    isAttending:            isAttending   ?? this.isAttending, 
    mutualAttendees:        mutualAttendees, 
    mutualAttendeesCount:   mutualAttendeesCount,
    distance:               distance,
    );
}
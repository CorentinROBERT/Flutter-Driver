class OpenRouteServiceResponse {
  final List<double> bbox;
  final List<Feature> features;
  final Metadata metadata;

  OpenRouteServiceResponse({
    required this.bbox,
    required this.features,
    required this.metadata,
  });

  factory OpenRouteServiceResponse.fromJson(Map<String, dynamic> json) {
    return OpenRouteServiceResponse(
      bbox: List<double>.from(json['bbox']),
      features:
          List<Feature>.from(json['features'].map((x) => Feature.fromJson(x))),
      metadata: Metadata.fromJson(json['metadata']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bbox': bbox,
      'features': features.map((x) => x.toJson()).toList(),
      'metadata': metadata.toJson(),
    };
  }
}

class Feature {
  final List<double> bbox;
  final String type;
  final Properties properties;
  final Geometry geometry;

  Feature({
    required this.bbox,
    required this.type,
    required this.properties,
    required this.geometry,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      bbox: List<double>.from(json['bbox']),
      type: json['type'],
      properties: Properties.fromJson(json['properties']),
      geometry: Geometry.fromJson(json['geometry']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bbox': bbox,
      'type': type,
      'properties': properties.toJson(),
      'geometry': geometry.toJson(),
    };
  }
}

class Properties {
  final List<Segment> segments;
  final List<int> wayPoints;
  final Summary summary;

  Properties({
    required this.segments,
    required this.wayPoints,
    required this.summary,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      segments:
          List<Segment>.from(json['segments'].map((x) => Segment.fromJson(x))),
      wayPoints: List<int>.from(json['way_points']),
      summary: Summary.fromJson(json['summary']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'segments': segments.map((x) => x.toJson()).toList(),
      'way_points': wayPoints,
      'summary': summary.toJson(),
    };
  }
}

class Segment {
  final double distance;
  final double duration;
  final List<Step> steps;

  Segment({
    required this.distance,
    required this.duration,
    required this.steps,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      distance: json['distance'].toDouble(),
      duration: json['duration'].toDouble(),
      steps: List<Step>.from(json['steps'].map((x) => Step.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      'steps': steps.map((x) => x.toJson()).toList(),
    };
  }
}

class Step {
  final double distance;
  final double duration;
  final int type;
  final String instruction;
  final String name;
  final List<int> wayPoints;
  final int? exitNumber;

  Step({
    required this.distance,
    required this.duration,
    required this.type,
    required this.instruction,
    required this.name,
    required this.wayPoints,
    this.exitNumber,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      distance: json['distance'].toDouble(),
      duration: json['duration'].toDouble(),
      type: json['type'],
      instruction: json['instruction'],
      name: json['name'],
      wayPoints: List<int>.from(json['way_points']),
      exitNumber: json['exit_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      'type': type,
      'instruction': instruction,
      'name': name,
      'way_points': wayPoints,
      if (exitNumber != null) 'exit_number': exitNumber,
    };
  }
}

class Summary {
  final double distance;
  final double duration;

  Summary({
    required this.distance,
    required this.duration,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      distance: json['distance'].toDouble(),
      duration: json['duration'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
    };
  }
}

class Geometry {
  final List<List<double>> coordinates;
  final String type;

  Geometry({
    required this.coordinates,
    required this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      coordinates: List<List<double>>.from(
          json['coordinates'].map((x) => List<double>.from(x))),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates.map((x) => x).toList(),
      'type': type,
    };
  }
}

class Metadata {
  final String attribution;
  final String service;
  final int timestamp;
  final Query query;
  final Engine engine;

  Metadata({
    required this.attribution,
    required this.service,
    required this.timestamp,
    required this.query,
    required this.engine,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      attribution: json['attribution'],
      service: json['service'],
      timestamp: json['timestamp'],
      query: Query.fromJson(json['query']),
      engine: Engine.fromJson(json['engine']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attribution': attribution,
      'service': service,
      'timestamp': timestamp,
      'query': query.toJson(),
      'engine': engine.toJson(),
    };
  }
}

class Query {
  final List<List<double>> coordinates;
  final String profile;
  final String format;

  Query({
    required this.coordinates,
    required this.profile,
    required this.format,
  });

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      coordinates: List<List<double>>.from(
          json['coordinates'].map((x) => List<double>.from(x))),
      profile: json['profile'],
      format: json['format'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates.map((x) => x).toList(),
      'profile': profile,
      'format': format,
    };
  }
}

class Engine {
  final String version;
  final String buildDate;
  final String graphDate;

  Engine({
    required this.version,
    required this.buildDate,
    required this.graphDate,
  });

  factory Engine.fromJson(Map<String, dynamic> json) {
    return Engine(
      version: json['version'],
      buildDate: json['build_date'],
      graphDate: json['graph_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'build_date': buildDate,
      'graph_date': graphDate,
    };
  }
}

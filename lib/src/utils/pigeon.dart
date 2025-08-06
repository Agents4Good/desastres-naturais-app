import 'package:pigeon/pigeon.dart';
// Command to generate pigeon files: dart run pigeon --input lib/src/utils/pigeon.dart

enum PreferredBackend {
  unknown,
  cpu,
  gpu,
  gpuFloat16,
  gpuMixed,
  gpuFull,
  tpu,
}

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/utils/pigeon.g.dart',
  kotlinOut: 'android/src/main/kotlin/dev/flutterberlin/flutter_gemma/PigeonInterface.g.kt',
  kotlinOptions: KotlinOptions(package: 'dev.agents4good.pluvia'),
  swiftOut: 'ios/Classes/PigeonInterface.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'flutter_gemma',
))
@HostApi()
abstract class PlatformService {
  @async
  void createModel({
    required int maxTokens,
    required String modelPath,
    required List<int>? loraRanks,
    PreferredBackend? preferredBackend,
    int? maxNumImages,
  });

  @async
  void closeModel();

  @async
  void createSession({
    required double temperature,
    required int randomSeed,
    required int topK,
    double? topP,
    String? loraPath,
    bool? enableVisionModality,
  });

  @async
  void closeSession();

  @async
  int sizeInTokens(String prompt);

  @async
  void addQueryChunk(String prompt);

  @async
  void addImage(Uint8List imageBytes);

  @async
  String generateResponse();

  @async
  void generateResponseAsync();
}
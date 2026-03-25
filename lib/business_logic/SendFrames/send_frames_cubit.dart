import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'send_frames_state.dart';

class SendFramesCubit extends Cubit<SendFramesState> {
  SendFramesCubit() : super(SendFramesInitial());
  final Dio dio = Dio();
  Future sendFrames() async {
    final response = await dio.post("",options: Options());
  }
}

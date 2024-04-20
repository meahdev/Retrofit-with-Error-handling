import 'package:flutter/material.dart';
import 'package:retrofit_with_error_handling/model/sample_response.dart';
import 'package:retrofit_with_error_handling/network/api_service.dart';

import '../core/connectivity.dart';
import '../core/snackbar_utils.dart';
import '../network/error_handler.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SampleScreen> {
  //loader flag whether to determine show the loader
  bool _isLoading = true;

  //list of posts
  final List<SampleResponse> _mPostList = [];

  //initializing the API Service class
  final ApiService _apiService = ApiService();

  //initialize the ConnectivityService class
  final ConnectivityService _connectivityService = ConnectivityService();

  // only triggers in the initial time of application
  @override
  void initState() {
    super.initState();

    // ensure all widgets are built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ))
          : SafeArea(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                itemCount: _mPostList.length,
                itemBuilder: (BuildContext context, int index) {
                  SampleResponse? item = _mPostList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title ?? ""),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(item.body ?? ""),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  //calling the sample API
  getPost() {
    //checking the connection
    _connectivityService.checkConnection().then((isConnected) {
      if (isConnected) {
        _apiService.getPosts().then((value) {
          List<SampleResponse>? response = value.data;
          if (value.getException != null) {
            //if there is any error ,it will trigger here and shown in snack-bar
            ErrorHandler errorHandler = value.getException;
            String msg = errorHandler.getErrorMessage();
            //got the exception and disabling the loader
            setState(() {
              _isLoading = false;
            });
            SnackBarUtils.showErrorSnackBar(context, msg);
          } else if (response != null) {
            //got the response and disabling the loader
            setState(() {
              _isLoading = false;
              _mPostList.addAll(response);
            });
          } else {
            //when response is null most cases are when status code becomes 204
            //disabling the loader
            setState(() {
              _isLoading = false;
            });
          }
        });
      } else {
        //when there is no connection
        //disabling the loader
        setState(() {
          _isLoading = false;
        });
        SnackBarUtils.showErrorSnackBar(context, "No internet connection");
      }
    });
  }
}

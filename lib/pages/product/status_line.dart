// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import '../../application/product_service.dart';
import '../../design/colors.dart';

class StatusLine extends StatefulWidget {
  const StatusLine({super.key});

  @override
  _StatusLine createState() => _StatusLine();
}

class _StatusLine extends State<StatusLine> {
  late final ProductService productService;
  late Future<bool> _currentConnection;

  @override
  void initState() {
    super.initState();
    productService = const ProductService();
    _currentConnection = productService.ping();
    setUpTimedFetch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _currentConnection,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Waiting for server response");
        }
        else if(snapshot.hasData) {
          return _statusRow(snapshot.data!);
        }
        else {
          return _statusRow(false);
        }
      } 
    );
  }

  Widget _statusRow(bool status) {
    return Container(
      color: secondaryBackgroundColor,
      child: _status(status),
    );
  }

  Widget _status(bool status) {
    if(status) {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lens,
            color: connectedColor,
          ),
          Text("Connected")
        ]
      );
    }
    else {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lens,
            color: disconnectedColor,
          ),
          Text("Disconnected")
        ]
      );
    }
  }

  setUpTimedFetch() {
    Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        _currentConnection = productService.ping();
      });
    });
  }
}
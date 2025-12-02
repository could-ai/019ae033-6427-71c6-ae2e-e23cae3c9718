import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnalysisResultPage extends StatefulWidget {
  const AnalysisResultPage({super.key});

  @override
  State<AnalysisResultPage> createState() => _AnalysisResultPageState();
}

class _AnalysisResultPageState extends State<AnalysisResultPage> {
  bool _isAnalyzing = true;
  String? _imagePath;
  
  // Simulation results
  String _prediction = '';
  Color _predictionColor = Colors.grey;
  double _confidence = 0.0;
  List<String> _patternFound = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_imagePath == null) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) {
        _imagePath = args;
        _startAnalysis();
      }
    }
  }

  void _startAnalysis() {
    // Simulate AI processing time
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _generateRandomPrediction();
        });
      }
    });
  }

  void _generateRandomPrediction() {
    final random = Random();
    final type = random.nextInt(3); // 0: Player, 1: Banker, 2: Tie
    
    // Simulate finding patterns
    _patternFound = [
      'Sequência Fibonacci Detectada',
      'Tendência de Reversão',
      'Volume de Apostas Alto'
    ];

    if (type == 0) {
      _prediction = 'PLAYER (AZUL)';
      _predictionColor = const Color(0xFF2979FF);
      _confidence = 85 + random.nextDouble() * 10;
    } else if (type == 1) {
      _prediction = 'BANKER (VERMELHO)';
      _predictionColor = const Color(0xFFFF1744);
      _confidence = 88 + random.nextDouble() * 10;
    } else {
      _prediction = 'TIE (EMPATE)';
      _predictionColor = const Color(0xFFFFD740);
      _confidence = 60 + random.nextDouble() * 20;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANÁLISE DE PADRÃO'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isAnalyzing ? _buildLoadingView() : _buildResultView(),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            'PROCESSANDO IMAGEM...',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Extraindo dados do histórico...',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Preview (Thumbnail)
          if (_imagePath != null)
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade800),
                image: DecorationImage(
                  image: kIsWeb 
                      ? NetworkImage(_imagePath!) 
                      : FileImage(File(_imagePath!)) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.check_circle, color: Colors.green, size: 40),
                ),
              ),
            ),
          
          const SizedBox(height: 30),

          // Prediction Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _predictionColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _predictionColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: _predictionColor.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'SINAL IDENTIFICADO',
                  style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: 2,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _prediction,
                  style: TextStyle(
                    color: _predictionColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: _confidence / 100,
                  backgroundColor: Colors.black,
                  color: _predictionColor,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 8),
                Text(
                  'CONFIANÇA: ${_confidence.toStringAsFixed(1)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Analysis Details
          const Text(
            'DETALHES DA ANÁLISE',
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 1.5,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _patternFound.map((pattern) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.analytics, size: 16, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(pattern, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              )).toList(),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'NOVA ANÁLISE',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

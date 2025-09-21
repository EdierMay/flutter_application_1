import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // usa tu firebase
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomepage(),
    );
  }
}

class MyHomepage extends StatelessWidget {
  const MyHomepage({super.key});

  Future<void> _guardarCitasDemo(BuildContext context) async {
    // Lista de citas
    final List<Map<String, dynamic>> citas = [
      {
        'paciente': 'Edier May',
        'motivo': 'Cirugía plastica',
        'fecha': '2025-09-09',
      },
      {
        'paciente': 'Jovita Chan',
        'motivo': 'Psicología',
        'fecha': '2025-10-10',
      },
      {
        'paciente': 'Santiago Sandoval',
        'motivo': 'Oftalmología',
        'fecha': '2025-11-11',
      },
      {
        'paciente': 'Brayan May',
        'motivo': 'Neuro cirugía',
        'fecha': '2025-12-12',
      },
      {
        'paciente': 'Alma Navarro',
        'motivo': 'Traumatología',
        'fecha': '2026-01-01',
      },
      {
        'paciente': 'Saul May',
        'motivo': 'Control del niño sano',
        'fecha': '2026-02-02',
      },
      {
        'paciente': 'Macario Dzul',
        'motivo': 'Cardiología',
        'fecha': '2026-03-03',
      },
      {
        'paciente': 'Amalin Soda',
        'motivo': 'Ginecología',
        'fecha': '2026-04-04',
      },
      {'paciente': 'Wilder Ceh', 'motivo': 'Urología', 'fecha': '2026-05-05'},
      {'paciente': 'Lilia Poot', 'motivo': 'Pediatría', 'fecha': '2026-06-06'},
      {
        'paciente': 'Sale Ramos',
        'motivo': 'Otorrinolaringología',
        'fecha': '2026-07-07',
      },
    ];

    // Guardar cada cita en Firestore
    for (var cita in citas) {
      await FirebaseFirestore.instance.collection('DocApp').add({
        ...cita,
        'creadoEn': FieldValue.serverTimestamp(),
      });
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡11 citas guardadas en Firestore!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Firebase')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _guardarCitasDemo(context),
          child: const Text('Guardar citas demo'),
        ),
      ),
    );
  }
}

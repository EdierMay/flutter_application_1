import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter/counter_bloc.dart';
import 'counter/counter_event.dart';
import 'counter/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Actividad BLoC - Contador',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CounterBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador con BLoC - Actividad 2'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            String statusText;
            switch (state.status) {
              case CounterStatus.initial:
                statusText = 'Inicial (cero)';
                break;
              case CounterStatus.positive:
                statusText = 'Positivo';
                break;
              case CounterStatus.negative:
                statusText = 'Negativo';
                break;
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Valor del contador:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  '${state.value}',
                  style: const TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(statusText, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 24),
                // Un pequeño hint o instrucción
                const Text(
                  'Usa los botones para incrementar, decrementar o reiniciar.',
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () => bloc.add(CounterDecremented()),
              icon: const Icon(Icons.remove),
              label: const Text('Decrementar'),
            ),
            ElevatedButton.icon(
              onPressed: () => bloc.add(CounterReset()),
              icon: const Icon(Icons.refresh),
              label: const Text('Reiniciar'),
            ),
            ElevatedButton.icon(
              onPressed: () => bloc.add(CounterIncremented()),
              icon: const Icon(Icons.add),
              label: const Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}

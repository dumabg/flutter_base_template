import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utils/widgets/single_child_scroll_view_scroll_drag.dart';
import 'package:web/web.dart' as $web;

// cSpell: disable

class MainUnexpectedErrorWidget extends StatelessWidget {
  const MainUnexpectedErrorWidget({required this.error, super.key});

  final String? error;

  @override
  Widget build(BuildContext context) {
    final errorInfo = error ?? 'Sem informação de erro';
    return MaterialApp(
      title: 'Indulge Me', // spell-checker: disable-line
      home: Scaffold(
        body: SingleChildScrollViewScrollDrag(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Erro inesperado',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Que pode ter acontecido?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '- Não conseguiu contatar com o servidor por '
                            'algum motivo.',
                          ),
                          SizedBox(height: 8),
                          Text(
                            '- Às vezes, os navegadores salvam arquivos '
                            'baixados do servidor, o que pode causar erros '
                            'quando há uma nova versão do aplicativo.',
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Que posso fazer?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Text(
                            '- Recarregue a página pressionando Ctrl+F5 ou '
                            'neste botão: ',
                          ),
                          IconButton(
                            onPressed: () => $web.window.location.reload(),
                            icon: const Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Ja tentei recarregar, mas continuo com problemas. '
                        'Que posso fazer?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Text('Copie'),
                          IconButton(
                            onPressed:
                                () async => Clipboard.setData(
                                  ClipboardData(text: errorInfo),
                                ),
                            icon: const Icon(Icons.copy),
                          ),
                          const Text(
                            ' as informações abaixo e envie um e-mail a',
                          ),
                          const SizedBox(width: 4),
                          const SelectableText('indulgeme.dev@gmail.com'),
                          IconButton(
                            onPressed:
                                () async => Clipboard.setData(
                                  const ClipboardData(
                                    text: 'indulgeme.dev@gmail.com',
                                  ),
                                ),
                            icon: const Icon(Icons.copy),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: SelectableText(errorInfo),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

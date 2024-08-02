import 'package:lawyer/components/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../utils/config.dart';

class AiPage extends StatefulWidget {
  const AiPage({Key? key}) : super(key: key);

  @override
  State<AiPage> createState() => _AiPage();
}

class _AiPage extends State<AiPage> {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  final FocusNode _textFieldFocus = FocusNode();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: "AIzaSyCuVxp9_50r0wnBfZgxItDALGySXgtRrE4"//const String.fromEnvironment('api_key'),
    );
    _chatSession = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(left: 5, top: 20, right: 5),
        child:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            const Text(
              'Destek Al',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _chatSession.history.length,
                  itemBuilder: (context, index) {
                    final Content content =
                    _chatSession.history.toList()[index];
                    final text = content.parts
                        .whereType<TextPart>()
                        .map<String>((e) => e.text)
                        .join('');
                    return Message(
                        text: text, isFromUser: content.role == 'user');
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 15,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      focusNode: _textFieldFocus,
                      decoration: textFieldDecoration(),
                      controller: _textController,
                      onSubmitted: _sendChatMessage,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (!_loading)
                    IconButton(
                      onPressed: () async {
                        _sendChatMessage(_textController.text);
                      },
                      icon: Icon(
                        Icons.send,
                        color: Config.primaryColor,
                      ),
                    )
                  else
                    const CircularProgressIndicator(),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }

  InputDecoration textFieldDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      hintText: 'Mesajınızı Yazınız',
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Config.primaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Config.primaryColor,
        ),
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });
    try {
      final response = await _chatSession.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      if (text == null) {
        _showError('No response from api');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrolDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _scrolDown() {
    WidgetsBinding.instance.addPersistentFrameCallback(
          (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  void _showError(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('something went wrong'),
            content: SingleChildScrollView(
              child: SelectableText(message),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('ok'),
              ),
            ],
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:code_editor/code_editor.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // example of a easier way to write code instead of writing it in a single string
    List<String> contentOfPage1 = [
      "<!DOCTYPE html>",
      "<html lang='fr'>",
      "\t<body>",
      "\t\t<a href='page2.html'>go to page 2</a>",
      "\t</body>",
      "</html>",
    ];

    // The files displayed in the navigation bar of the editor.
    // You are not limited.
    // By default, [name] = "file.${language ?? 'txt'}", [language] = "text" and [code] = "",
    List<FileEditor> files = [
      FileEditor(
        name: "page1.html",
        language: "html",
        code: contentOfPage1.join("\n"), // [code] needs a string
      ),
      FileEditor(
        name: "page2.html",
        language: "html",
        code: "<a href='page1.html'>go back</a>",
      ),
      FileEditor(
        name: "style.css",
        language: "css",
        code: "a { color: red; }",
      ),
    ];

    // The model used by the CodeEditor widget, you need it in order to control it.
    // But, since 1.0.0, the model is not required inside the CodeEditor Widget.
    // To start without a model, you need to use `CodeEditor.empty()`.
    EditorModel model = EditorModel(
      files: files, // the files created above
      // you can customize the editor as you want
      styleOptions: EditorModelStyleOptions(
        showUndoRedoButtons: false,
        reverseEditAndUndoRedoButtons: true,
      )..defineEditButtonPosition(
          bottom: 10,
          left: 15,
        ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("code_editor example")),
      // /!\ The SingleChildScrollView is important because of the phone's keypad which causes a "RenderFlex overflowed by x pixels on the bottom" error
      body: SingleChildScrollView(
        child: CodeEditor(
          model: model,
          readonly: false,
          formatters: const ["html"],
          onSubmit: (String language, String value) => print("A file of language $language was edited."),
        ),
      ),
    );
  }
}

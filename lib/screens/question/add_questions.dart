import 'package:flutter/material.dart';
import 'package:quizzed/constant.dart';

class AddQuestionsScreen extends StatefulWidget {
  const AddQuestionsScreen({super.key});

  @override
  State<AddQuestionsScreen> createState() => _AddQuestionsScreenState();
}

class _AddQuestionsScreenState extends State<AddQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    var questionsCount = ModalRoute.of(context)!.settings.arguments as int;

    List<TextEditingController> questionBodies = [];
    List<TextEditingController> answers = [];

    for (var i = 0; i < questionsCount; i++) {
      questionBodies.add(TextEditingController());
      answers.add(TextEditingController());
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Questions'),
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: questionsCount,
                  itemBuilder: (BuildContext context, int index) {

                    return Column(
                      children: [
                        TextFormField(
                          controller: questionBodies.elementAt(index),
                          style: TextStyle(
                              fontFamily: baseFontFamily,
                              fontSize: inputFontSize),
                          decoration: InputDecoration(
                            hintText: "Question Body #${index + 1}",
                            hintStyle: TextStyle(
                                fontFamily: baseFontFamily,
                                fontSize: inputFontSize),
                            focusColor: primaryColor,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          controller: answers.elementAt(index),
                          style: TextStyle(
                              fontFamily: baseFontFamily,
                              fontSize: inputFontSize),
                          decoration: InputDecoration(
                            hintText: "Answer #${index + 1}",
                            hintStyle: TextStyle(
                                fontFamily: baseFontFamily,
                                fontSize: inputFontSize),
                            focusColor: primaryColor,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  for (var body in questionBodies) { 
                    print('Question: ${body.text}');
                  }
                  for (var answer in answers) { 
                    print('Answer: ${answer.text}');
                  }
                },
                child: Text(
                  'Add Questions',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            ],
          )),
    );
  }
}

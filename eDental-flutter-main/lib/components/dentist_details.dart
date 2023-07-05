import 'package:edental/apimodels/ratingSearchRequest.dart';
import 'package:edental/components/text_dialog.dart';
import 'package:edental/providers/ratingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/dentist.dart';
import '../models/rating.dart';
import '../providers/auth.dart';

class DentistDetails extends StatefulWidget {
  DentistDetails(this.dentist, {super.key});
  Dentist dentist;

  @override
  State<DentistDetails> createState() => _DentistDetailsState();
}

String _text = '';
Future<void> showTextDialog(BuildContext context) async {
  final text = await showDialog<String>(
    context: context,
    builder: (context) => TextDialog(title: 'Enter some text'),
  );

  if (text != null) {
    _text = text;
  }
}

class _DentistDetailsState extends State<DentistDetails> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ratingService = Provider.of<RatingService>(context);
    final authProvider = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            const SizedBox(
              height: 25,
            ),
            CircleAvatar(
              maxRadius: 80,
              backgroundImage: MemoryImage(widget.dentist.image),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(widget.dentist.fullName),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: deviceSize.width / 1.5,
              child: TextField(
                readOnly: true,
                maxLines: 10,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: widget.dentist.description,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Overall rating:"),
                FutureBuilder(
                  future:
                      ratingService.calculateDentistRating(widget.dentist.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data!.toStringAsFixed(2));
                    }
                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<bool>(
                future: ratingService.checkIfRatingApproved(
                    authProvider.user!.id ?? 0, widget.dentist.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bool canRate = snapshot.data ?? false;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rate now:',
                          style: TextStyle(
                              color: canRate ? Colors.amber : Colors.grey),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        RatingBar.builder(
                          minRating: 1,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 15,
                          ignoreGestures: !canRate,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) async {
                            await showTextDialog(context);
                            var request = Rating(
                                value.round(),
                                _text,
                                DateTime.now(),
                                authProvider.user!.id!,
                                widget.dentist.id,
                                dentistFullName: widget.dentist.fullName,
                                clientFullName: authProvider.user!.fullName,
                                id: 0);
                            final result = await ratingService.create(request);
                            if (result != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Rating was created')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Something went wrong. Try again!')));
                            }
                          },
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                }),
            const SizedBox(
              height: 5,
            ),
            FutureBuilder(
                future: ratingService.find(
                    RatingSearchRequest(null, widget.dentist.id),
                    path: "/filtering"),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(snapshot.data![index].clientFullName!),
                        subtitle: TextField(
                            readOnly: true,
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintText: snapshot.data![index].comment)),
                        trailing: RatingBar.builder(
                          initialRating: double.parse(
                              snapshot.data![index].rate.toString()),
                          minRating: 1,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 15,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ]),
        ),
      ),
    );
  }
}

import 'package:edental/components/dentist_details.dart';
import 'package:edental/providers/ratingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../models/dentist.dart';
import '../../providers/auth.dart';

class Recommendations extends StatefulWidget {
  final List<Dentist> _recommendedDentists;
  final String sectionTitle;
  Recommendations(this._recommendedDentists, this.sectionTitle, {super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  @override
  Widget build(BuildContext context) {
    final ratingService = Provider.of<RatingService>(context);
    final auth = Provider.of<Auth>(context);
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          widget.sectionTitle,
          style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              backgroundColor: Color.fromARGB(137, 0, 162, 255)),
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text(widget._recommendedDentists[index].fullName),
            subtitle: TextField(
              style: const TextStyle(fontSize: 10),
              readOnly: true,
              maxLines: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: widget._recommendedDentists[index].description,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) =>
                        DentistDetails(widget._recommendedDentists[index]));
              },
              child: CircleAvatar(
                backgroundImage:
                    MemoryImage(widget._recommendedDentists[index].image),
              ),
            ),
            trailing: FutureBuilder(
                future: ratingService.calculateDentistRating(
                    widget._recommendedDentists[index].id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        RatingBar.builder(
                          initialRating: snapshot.data!,
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
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                }),
          ),
          itemCount: widget._recommendedDentists.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        )
      ]),
    );
  }
}

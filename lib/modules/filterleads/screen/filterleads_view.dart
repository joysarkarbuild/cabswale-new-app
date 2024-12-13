import 'package:cabswalle/constants/assets.dart';
import 'package:cabswalle/modules/filterleads/screen/widgets/scrolling_text.dart';
import 'package:cabswalle/modules/home/data/models/lead_data_model.dart';
import 'package:flutter/material.dart';

import '../../../widgets/lead_card.dart';

class FilterLeadsScreen extends StatefulWidget {
  const FilterLeadsScreen({
    super.key,
    required this.city,
  });

  final String city;

  @override
  State<FilterLeadsScreen> createState() => _FilterLeadsScreenState();
}

class _FilterLeadsScreenState extends State<FilterLeadsScreen> {
  bool notificationAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.city.isNotEmpty
                ? "Leads from ${widget.city}"
                : "Duties at your Location",
            style: TextStyle(
                fontSize: widget.city.isNotEmpty ? 20 : 18,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: widget.city.isNotEmpty,
          actions: [
            if (widget.city.isEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  height: 40,
                  child: FittedBox(
                    child: Switch(
                      value: notificationAlert,
                      onChanged: (val) {},
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => Column(
              children: [
                if (index == 0)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Image.asset(
                          Assets.imagesLoading,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration:
                            BoxDecoration(color: Colors.red.withOpacity(0.4)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              child: const ScrollingText(
                                text:
                                    "Please recharge now. You may miss your duty as recharge might take 5-10 mins.     कृपया अभी रिचार्ज करें. आपकी ड्यूटी छूट सकती है क्योंकि रिचार्ज में 5-10 मिनट लग सकते हैं।      Kirapā karakē huṇē rīcāraja karō. Tusīṁ āpaṇī ḍi’ūṭī gu’ā sakadē hō ki’uṅki rīcāraja vica 5-10 miṭa laga sakadē hana.      ",
                                ratioOfBlankToScreen: 0,
                                scrollAxis: Axis.horizontal,
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                minimumSize: const Size(100,
                                    30), // Adjust the size as per your requirement
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical:
                                        6), // Adjust the padding as per your requirement
                              ),
                              child: const Text('Recharge Now',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: LeadsCard(lead: LeadModel()),
                ),
              ],
            ),
          ),
        ));
  }
}

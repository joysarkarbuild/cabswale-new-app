import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.only(left: 8, top: 2, bottom: 2),
                    border: OutlineInputBorder(),
                    hintText: 'Search location',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      "Pinned Locations",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "No Pinned locations",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey),
                ),
                ...[].map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            if (e["img"] == "")
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(
                                  "assets/icons/defaultCity.png",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            if (e["img"] != "")
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  e["img"],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              e["name"].toString().toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/icons/pin_filled.svg",
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      "All Locations",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ...[].map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            if (e["img"] == "")
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(
                                  "assets/icons/defaultCity.png",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            if (e["img"] != "")
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  e["img"],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              e["name"].toString().toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/icons/pin.svg",
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                ...[].map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            if (e["img"] == "")
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(
                                  "assets/icons/defaultCity.png",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            if (e["img"] != "")
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  e["img"],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              e["name"].toString().toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/icons/pin.svg",
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

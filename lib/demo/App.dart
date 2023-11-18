import 'package:flutter/material.dart';
import 'package:flutter_study/demo/widgets/Button.dart';
import 'package:flutter_study/demo/widgets/CurrencyCard.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SelectionArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Hey, Selena',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text('Welcome back',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.8),
                                fontSize: 18,
                              ))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Total Balance',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white.withOpacity(0.8),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    '\$5 194 482',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        title: 'Transfer',
                        bgColor: Colors.amber,
                        textColor: Colors.black,
                      ),
                      Button(
                        title: 'Request',
                        bgColor: Color(0xFF1F2123),
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Wallets',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CurrencyCard(
                    title: 'Euro',
                    amount: '6 428',
                    currency: 'EUR',
                    isInverted: false,
                    icon: Icons.euro_rounded,
                    order: 1,
                  ),
                  CurrencyCard(
                    title: 'Bitcoin',
                    amount: '9 785',
                    currency: 'BTC',
                    isInverted: true,
                    icon: Icons.currency_bitcoin_rounded,
                    order: 2,
                  ),
                  CurrencyCard(
                    title: 'Dollar',
                    amount: '428',
                    currency: 'USD',
                    isInverted: false,
                    icon: Icons.attach_money_outlined,
                    order: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

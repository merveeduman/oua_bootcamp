import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingPage1(),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(pages: [
        OnboardingPageModel(
          title: 'Profesyonel Destek Her Anınızda',
          description:'Avukatlarımızla her an bağlantıda olun. Profesyonel destek ve güvenilir hukuk danışmanlığı ile hukuki çözümler size özel sunulur."',
          imageUrl: 'https://www.mehmetalisofuoglu.av.tr/wp-content/uploads/2021/12/avukat-mehmet-ali-sofuoglu-konsey-hukuk-beylikduzu-avukat-istanbul-3.png',
          bgColor: const Color(0xff003366),
        ),
        OnboardingPageModel(
          title: 'Hukuki İhtiyaçlarınız İçin Hızlı ve Verimli Çözümler',
          description:'Hukuki ihtiyaçlarınızı en hızlı ve verimli şekilde karşılamak için buradayız.',
          imageUrl: 'https://tirelisavashukuk.com/wp-content/uploads/2021/02/izmir-avukat.png',
          bgColor: const Color(0xFF8B4513),
        ),
        OnboardingPageModel(
          title: 'Hukuki Zorlukları Aşmanın Kolay Yolu',
          description:'Uygulamamızla hızlı, güvenilir ve etkili hukuki çözümler size özel sunulur.',
          imageUrl: 'https://www.pngmart.com/files/17/Gavel-Justice-PNG-Transparent-Image.png',
          bgColor: const Color(0xFF800000),
        ),
        OnboardingPageModel(
          title: 'İşlemlerinizi Yapay Zeka İle Kolaylaştırın',
          description:'Hukuki sorunlarınızı çözmenin yanı sıra, yapay zeka destekli sözleşme oluşturma imkanı da sunuyoruz.',
          imageUrl: 'https://www.cybermagonline.com/upload/yapay-zeka-etik-6.png',
          bgColor: const Color(0xff333333),
        ),
      ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter(
      {Key? key, required this.pages, this.onSkip, this.onFinish})
      : super(key: key);

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  // Store the currently visible page
  int _currentPage = 0;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.network(
                              item.imageUrl,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(item.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: item.textColor,
                                  )),
                            ),
                            Container(
                              constraints:
                              const BoxConstraints(maxWidth: 280),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 8.0),
                              child: Text(item.description,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                    color: item.textColor,
                                  )),
                            )
                          ]),
                        )
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: _currentPage == widget.pages.indexOf(item)
                      ? 30
                      : 8,
                  height: 8,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            visualDensity: VisualDensity.comfortable,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          widget.onSkip?.call();
                        },
                        child: const Text("")),
                    TextButton(
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.comfortable,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          widget.onFinish?.call();
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == widget.pages.length - 1
                                ? "Bitti"
                                : "Devam",
                          ),
                          const SizedBox(width: 8),
                          Icon(_currentPage == widget.pages.length - 1
                              ? Icons.done
                              : Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
        required this.description,
        required this.imageUrl,
        this.bgColor = Colors.blue,
        this.textColor = Colors.white});
}

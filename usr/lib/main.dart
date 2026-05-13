import 'package:flutter/material.dart';

void main() {
  runApp(const MassSpecPresentationApp());
}

class MassSpecPresentationApp extends StatelessWidget {
  const MassSpecPresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mass Spectrometry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: const Color(0xFF1E1E2C),
        colorScheme: ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.cyanAccent,
          surface: const Color(0xFF2A2A3D),
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationDeck(),
      },
    );
  }
}

class PresentationDeck extends StatefulWidget {
  const PresentationDeck({super.key});

  @override
  State<PresentationDeck> createState() => _PresentationDeckState();
}

class _PresentationDeckState extends State<PresentationDeck> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: 'Mass Spectrometry (MS)',
      subtitle: 'An Analytical Technique for Molecular Analysis',
      content: 'Mass Spectrometry is an analytical tool used for measuring the mass-to-charge ratio (m/z) of one or more molecules present in a sample. These measurements can often be used to calculate the exact molecular weight of the sample components as well.',
      icon: Icons.science,
    ),
    SlideData(
      title: 'Basic Principle',
      subtitle: 'How does it work?',
      content: '1. Ionization: The sample is ionized, for example by bombarding it with electrons.\n\n2. Acceleration: The ions are accelerated so that they all have the same kinetic energy.\n\n3. Deflection: The ions are deflected by a magnetic field according to their masses. The lighter they are, the more they are deflected.\n\n4. Detection: The beam of ions passing through the machine is detected electrically.',
      icon: Icons.auto_graph,
    ),
    SlideData(
      title: 'Instrumentation',
      subtitle: 'The core components of an MS system',
      content: 'Every mass spectrometer consists of three essential parts:\n\n• Ion Source: Converts gas phase sample molecules into ions (e.g., ESI, MALDI).\n• Mass Analyzer: Sorts the ions by their masses by applying electromagnetic fields (e.g., Quadrupole, Time-of-Flight).\n• Detector: Measures the value of an indicator quantity and thus provides data for calculating the abundances of each ion present.',
      icon: Icons.precision_manufacturing,
    ),
    SlideData(
      title: 'Common Ionization Methods',
      subtitle: 'Creating gas-phase ions',
      content: '• Electron Impact (EI): Hard ionization, causes extensive fragmentation.\n• Electrospray Ionization (ESI): Soft ionization, excellent for large biomolecules like proteins.\n• Matrix-Assisted Laser Desorption/Ionization (MALDI): Uses a laser energy absorbing matrix to create ions from large molecules with minimal fragmentation.',
      icon: Icons.bolt,
    ),
    SlideData(
      title: 'Key Applications',
      subtitle: 'Where is Mass Spectrometry used?',
      content: '• Proteomics: Identifying and quantifying proteins.\n• Drug Discovery: Pharmacokinetics and drug metabolism studies.\n• Environmental Analysis: Detecting toxins or pesticides in water and soil.\n• Clinical Diagnostics: Identifying biomarkers for diseases.\n• Space Exploration: Analyzing planetary atmospheres and soil composition.',
      icon: Icons.public,
    ),
    SlideData(
      title: 'Conclusion',
      subtitle: 'Summary',
      content: 'Mass Spectrometry is a versatile, highly sensitive, and selective technique. When coupled with chromatographic methods (like LC-MS or GC-MS), it becomes one of the most powerful analytical tools available in modern chemistry and biology.',
      icon: Icons.lightbulb,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              return SlideWidget(
                slide: _slides[index],
                isDesktop: isDesktop,
              );
            },
          ),
          
          // Navigation Overlay
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _currentPage > 0 ? _prevPage : null,
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: _currentPage > 0 ? Colors.white : Colors.white38,
                  iconSize: 32,
                ),
                Text(
                  'Slide ${_currentPage + 1} of ${_slides.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                IconButton(
                  onPressed: _currentPage < _slides.length - 1 ? _nextPage : null,
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: _currentPage < _slides.length - 1 ? Colors.white : Colors.white38,
                  iconSize: 32,
                ),
              ],
            ),
          ),
          
          // Progress Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / _slides.length,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              minHeight: 4,
            ),
          )
        ],
      ),
    );
  }
}

class SlideData {
  final String title;
  final String subtitle;
  final String content;
  final IconData icon;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.icon,
  });
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;
  final bool isDesktop;

  const SlideWidget({
    super.key,
    required this.slide,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100.0 : 32.0,
        vertical: 64.0,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          padding: EdgeInsets.all(isDesktop ? 48.0 : 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                slide.icon,
                size: isDesktop ? 64 : 48,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: 24),
              Text(
                slide.title,
                style: TextStyle(
                  fontSize: isDesktop ? 48 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                slide.subtitle,
                style: TextStyle(
                  fontSize: isDesktop ? 24 : 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    slide.content,
                    style: TextStyle(
                      fontSize: isDesktop ? 22 : 18,
                      height: 1.6,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

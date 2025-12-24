import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wedding_landing_page/landingpage/donate_page.dart';
import 'package:wedding_landing_page/landingpage/final_page.dart';
import 'package:wedding_landing_page/landingpage/invite_page.dart';
import 'package:wedding_landing_page/landingpage/memory_book_page.dart';
import 'package:wedding_landing_page/landingpage/moment_page.dart';
import 'package:wedding_landing_page/landingpage/moment_page_3.dart';
import 'package:wedding_landing_page/landingpage/story_page.dart';
import 'package:wedding_landing_page/landingpage/welcomepage.dart';
import 'package:wedding_landing_page/mvvm/blessing_pop_up_view.dart';
import 'package:wedding_landing_page/mvvm/music_view_model.dart';
import 'package:wedding_landing_page/service/blessing_service.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'agenda_page.dart';
import 'moment_page_2.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with WidgetsBindingObserver {
  final PageController _pageController = PageController(initialPage: 0);
  IndexedScrollController scrollController = IndexedScrollController(
    initialIndex: 0,
    initialScrollOffset: 0.0,
  );
  int? lastPage;
  BlessingService service = BlessingService();
  bool isPlaying = false;
  final AudioPlayer _player = AudioPlayer();
  final MusicViewModel musicViewModel = MusicViewModel();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _player.setAsset("assets/audio/song.mp3");
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        musicViewModel.isPlaying.value = false;
      }
    });
  }

  @override
  void dispose() {
    print("dispose");
    WidgetsBinding.instance.removeObserver(this);
    service.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state.name);
  }

  final GlobalKey<InvitePageState> invitePageKey = GlobalKey();
  final GlobalKey<WelcomePageState> welcomePageKey = GlobalKey();
  final GlobalKey<StoryPageState> storyPageKey = GlobalKey();
  final GlobalKey<MomentPageState> momentPageKey = GlobalKey();
  final GlobalKey<SecondMomentPageState> secondMomentPageKey = GlobalKey();
  final GlobalKey<ThirdMomentPageState> thirdMomentPageKey = GlobalKey();
  final GlobalKey<AgendaPageState> agendaPageKey = GlobalKey();
  final GlobalKey<DonatePageState> donatePageKey = GlobalKey();
  final GlobalKey<FinalPageState> finalPageKey = GlobalKey();
  final GlobalKey<MemoryPageState> memoryBookKey = GlobalKey();
  void toggleMusic() async {
    if (musicViewModel.isPlaying.value){
      await _player.pause();
    } else {
      if (_player.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
      }
      await _player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: musicViewModel.isPlaying,
        builder: (context, playing, _) {
          return FloatingActionButton(
              onPressed: () {
              toggleMusic();
              musicViewModel.toggle();}, child: playing
                  ? Lottie.asset("assets/lotties/player music.json")
                  : Lottie.asset("assets/lotties/Play Button Pulse.json"));},
      ),
      body:
      Stack(children: [
        ResponsiveBuilder(
          builder: (context, constraint) {
            return (constraint.isDesktop)
                ? buildCarousel()
                : buildMobileCarousel();
          }
        ),
        BlessingPopUpView(),
      ])
    );
  }

  Widget buildCarousel() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      controller: _pageController,
      itemCount: 10,
      itemBuilder: (context, index) {
        if (index == 0) {
          return WelcomePage(key: welcomePageKey);
        }
        if (index == 1) {
          return InvitePage(key: invitePageKey);
        }
        if (index == 2) {
          return StoryPage(key: storyPageKey,);
        }
        if (index == 3) {
          return MomentPage(key: momentPageKey);
        }
        if (index == 4) {
          return SecondMomentPage(key: secondMomentPageKey,);
        }
        if (index == 5) {
          return ThirdMomentPage(key: thirdMomentPageKey,);
        }
        if (index == 6) {
          return AgendaPage(key: agendaPageKey);
        }
        if (index == 7) {
          return DonatePage(key: donatePageKey,);
        }
        if (index == 8) {
          return MemoryBookPage(key: memoryBookKey,);
        }
        if (index == 9) {
          return FinalPage(key: finalPageKey,);
        }
      },
    );
  }

  Widget buildMobileCarousel() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      allowImplicitScrolling: false,
      itemBuilder: (context, index) {
        if (index == 0) {
          return WelcomePage(key: welcomePageKey);
        }
        if (index == 1) {
          return InvitePage(key: invitePageKey);
        }
        if (index == 2) {
          return StoryPage(key: storyPageKey,);
        }
        if (index == 3) {
          return MomentPage(key: momentPageKey);
        }
        if (index == 4) {
          return SecondMomentPage(key: secondMomentPageKey,);
        }
        if (index == 5) {
          return ThirdMomentPage(key: thirdMomentPageKey,);
        }
        if (index == 6) {
          return AgendaPage(key: agendaPageKey);
        }
        if (index == 7) {
          return DonatePage(key: donatePageKey,);
        }
        if (index == 8) {
          return MemoryBookPage(key: memoryBookKey,);
        }
        if (index == 9) {
          return FinalPage(key: finalPageKey,);
        }
      });
  }
}
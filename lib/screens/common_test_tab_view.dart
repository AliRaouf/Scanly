import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:scanly/bloc/test/test_cubit.dart';
import 'package:scanly/screens/blood_screen.dart';
import 'package:scanly/screens/urine_screen.dart';
import 'genetic_screen.dart';

class CommonTestTabView extends StatefulWidget {
  CommonTestTabView({super.key, required this.index});

  int index;

  @override
  State<CommonTestTabView> createState() => _CommonTestTabViewState();
}

class _CommonTestTabViewState extends State<CommonTestTabView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String bloodOutlined = '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48"><path fill="currentColor" fill-rule="evenodd" d="M24 42c6.663 0 12-5.29 12-11.737c0-5.357-3.178-11.486-6.645-16.502A72.945 72.945 0 0 0 24 6.95a72.945 72.945 0 0 0-5.355 6.811C15.178 18.777 12 24.906 12 30.263C12 36.709 17.337 42 24 42M22.64 5.47C19.122 9.409 10 20.56 10 30.263C10 37.85 16.268 44 24 44s14-6.15 14-13.737C38 20.56 28.878 9.409 25.36 5.47C24.52 4.53 24 4 24 4s-.52.53-1.36 1.47" clip-rule="evenodd"/></svg>';
    String dnaIcon='<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 32 32"><g fill="currentColor"><path d="M22.207 3.707a1 1 0 0 0-1.414-1.414c-1.777 1.777-2.477 3.517-2.496 5.243c-.01.944.186 1.844.46 2.685c-.717-.227-1.466-.402-2.225-.439c-1.597-.077-3.178.45-4.74 2.01c-1.552 1.553-2.108 3.12-2.089 4.704c.008.674.123 1.341.285 1.985c-.767-.183-1.573-.297-2.406-.261c-1.75.074-3.51.795-5.29 2.573a1 1 0 1 0 1.415 1.414c.137-.137.273-.265.407-.386L6.793 24.5l.707-.707l-2.597-2.597a5.73 5.73 0 0 1 1.373-.713l2.267 2.267l.707-.707l-1.81-1.81a4.36 4.36 0 0 1 .228-.015c1.247-.053 2.48.343 3.865.847l.36.131c1.226.45 2.604.957 3.998 1.022c1.632.076 3.248-.442 4.816-2.011c1.57-1.57 2.066-3.166 1.93-4.776a6.407 6.407 0 0 0-.046-.397c-.591-.534-1.612-.803-2.301-.97c.161.467.28.912.335 1.354l-1.668-1.668l-.707.707l2.306 2.307c-.154.605-.502 1.239-1.16 1.924L16.706 16l-.707.707l2.651 2.651c-.613.469-1.2.71-1.776.81L14.708 18l-.707.707l1.462 1.462c-.906-.13-1.846-.473-2.933-.87l-.238-.087c-.328-1-.578-1.871-.588-2.74v-.062l1.59 1.59l.707-.707l-2.104-2.104c.172-.515.474-1.05.969-1.617L15.293 16l.707-.707l-2.427-2.427c.726-.632 1.4-.932 2.045-1.04l1.925 1.924l.707-.707l-1.193-1.193c.823.141 1.676.468 2.667.847l.295.113c1.304.496 2.826 1.043 4.478.97c1.712-.075 3.439-.802 5.21-2.573a1 1 0 0 0-1.414-1.414l-.148.145l-2.688-2.688l-.707.707l2.638 2.638c-.584.451-1.134.747-1.655.93L23.457 9.25l-.707.707l1.816 1.816a4.65 4.65 0 0 1-.157.01c-1.032.045-2.044-.242-3.155-.647c-.548-1.285-.97-2.422-.957-3.578v-.053l1.746 1.745l.707-.707l-2.25-2.25c.168-.527.453-1.085.907-1.679l2.636 2.636l.707-.707l-2.688-2.688c.047-.05.096-.098.145-.148"/><path d="M11.04 21.86c.642.449 1.449.89 2.266 1.063a7.72 7.72 0 0 1 .05 1.607c-.13 1.697-.884 3.412-2.649 5.177a1 1 0 0 1-1.414-1.414c.23-.23.435-.454.62-.674L7.5 25.207l.707-.707l2.306 2.306c.318-.497.53-.97.664-1.422L9.25 23.457l.707-.707l1.417 1.417c.027-.762-.112-1.515-.334-2.308"/></g></svg>';
    String bloodFilled = '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48"><g fill="currentColor"><path d="M38 30.263C38 37.85 31.732 44 24 44s-14-6.15-14-13.737C10 18.243 24 4 24 4s14 14.242 14 26.263"/><path fill-rule="evenodd" d="M24 42c6.663 0 12-5.29 12-11.737c0-5.357-3.178-11.486-6.645-16.502A72.945 72.945 0 0 0 24 6.95a72.945 72.945 0 0 0-5.355 6.811C15.178 18.777 12 24.906 12 30.263C12 36.709 17.337 42 24 42M22.64 5.47C19.122 9.409 10 20.56 10 30.263C10 37.85 16.268 44 24 44s14-6.15 14-13.737C38 20.56 28.878 9.409 25.36 5.47C24.52 4.53 24 4 24 4s-.52.53-1.36 1.47" clip-rule="evenodd"/></g></svg>';
    String urineIcon='<svg height="200px" width="200px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512" xml:space="preserve" fill="#000000"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path style="fill:#C7E9F4;" d="M427.392,113.736H84.608c-13.191,0-23.692,11.064-23.019,24.227l18.01,352.165 C80.226,502.384,90.346,512,102.619,512h306.764c12.272,0,22.392-9.616,23.019-21.873l18.01-352.165 C451.084,124.789,440.572,113.736,427.392,113.736z"></path> <path style="fill:#80D0E1;" d="M427.392,113.736H256.001V512h153.381c12.272,0,22.392-9.616,23.019-21.873l18.01-352.165 C451.084,124.789,440.572,113.736,427.392,113.736z"></path> <path style="fill:#FFC72D;" d="M178.822,409.327h154.356c12.73,0,23.05-10.32,23.05-23.05v-107.4c0-12.73-10.32-23.05-23.05-23.05 H178.822c-12.73,0-23.05,10.32-23.05,23.05v107.4C155.772,399.007,166.093,409.327,178.822,409.327z"></path> <path style="fill:#74B8E5;" d="M479.108,159.835H32.892c-12.73,0-23.05-10.32-23.05-23.05V23.05C9.842,10.32,20.162,0,32.892,0 h446.214c12.73,0,23.05,10.32,23.05,23.05v113.736C502.158,149.515,491.838,159.835,479.108,159.835z"></path> <path style="fill:#3797D3;" d="M479.108,0H256.001v159.835h223.107c12.73,0,23.05-10.32,23.05-23.05V23.05 C502.158,10.32,491.838,0,479.108,0z"></path> <path style="fill:#FFBE00;" d="M333.178,255.826h-77.177v153.501h77.177c12.73,0,23.05-10.32,23.05-23.05v-107.4 C356.228,266.146,345.907,255.826,333.178,255.826z"></path> </g></svg>';
    String urineIdle='<svg fill="#8c8c8c" height="200px" width="200px" version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512" xml:space="preserve" stroke="#8c8c8c"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <g> <g> <path d="M479.107,0H32.893c-12.73,0-23.05,10.32-23.05,23.05v113.736c0,12.73,10.32,23.05,23.05,23.05h29.814l16.891,330.292 C80.225,502.384,90.345,512,102.617,512h306.764c12.272,0,22.392-9.616,23.019-21.873l16.891-330.292h29.816 c12.73,0,23.05-10.32,23.05-23.05V23.05C502.157,10.32,491.837,0,479.107,0z M387.479,465.9H124.518l-15.651-306.065h294.265 L387.479,465.9z M456.057,113.736c-10.786,0-388.31,0-400.115,0V46.1h400.115V113.736z"></path> <path d="M178.821,409.327h154.356c12.73,0,23.05-10.32,23.05-23.05V278.875c0-12.73-10.32-23.05-23.05-23.05H178.821 c-12.73,0-23.05,10.32-23.05,23.05v107.401C155.772,399.007,166.092,409.327,178.821,409.327z M201.871,301.925h108.256v61.302 H201.871V301.925z"></path> </g> </g> </g> </g></svg>';
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: widget.index);

    return BlocConsumer<TestCubit, TestState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return PersistentTabView(
            gestureNavigationEnabled: true,
            navBarHeight: 60.h,
            controller: _controller,
            tabs: [
              PersistentTabConfig(
                screen: BloodScreen(),
                item: ItemConfig(opacity: 0.65,
                  activeForegroundColor: Colors.red,textStyle: GoogleFonts.nunito(fontWeight:FontWeight.w600),
                  inactiveIcon: Iconify(bloodOutlined,color: Colors.grey,),
                  icon:Iconify(bloodFilled,color: Colors.red,size: 42,),
                  title: "Blood",
                ),
              ),
              PersistentTabConfig(
                screen: GeneticScreen(),
                item: ItemConfig(opacity: 0.65,
                  inactiveIcon:Iconify(dnaIcon,color: Colors.grey),
                  activeForegroundColor: Color(0xff9266cc),textStyle: GoogleFonts.nunito(fontWeight:FontWeight.w600),
                  icon: Iconify(dnaIcon,size: 42,color: Color(0xff9266cc),),
                  title: "Genetic",
                ),
              ),
              PersistentTabConfig(
                screen: UrineScreen(),
                item: ItemConfig(opacity: 0.65,
                  activeForegroundColor: Color(0xff74B8E5),textStyle: GoogleFonts.nunito(fontWeight:FontWeight.w600),
                  inactiveIcon: Iconify(urineIdle),
                  icon: Iconify(urineIcon,size: 28),
                  title: "Urine",
                ),
              ),
            ], navBarBuilder: (navBarConfig) =>
                Style4BottomNavBar(
                    navBarConfig: navBarConfig));
      },
    );
  }
}

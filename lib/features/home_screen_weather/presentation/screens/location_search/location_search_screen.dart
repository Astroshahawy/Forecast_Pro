import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:forecast_pro/core/constants/constants.dart';
import 'package:forecast_pro/features/home_screen_weather/domain/entities/search_item.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/cubit/home_weather_cubit.dart';
import 'package:forecast_pro/features/home_screen_weather/presentation/screens/location_search/add_location_app_bar.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LocationSearchScreen extends StatelessWidget {
  const LocationSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundColor.shade700,
            AppColors.backgroundColor.shade500,
            AppColors.backgroundColor.shade300,
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 70),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                const AddLocationTopBar(),
                const SizedBox.square(
                  dimension: 20,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white60,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TypeAheadField<SearchItem>(
                    animationStart: 0,
                    animationDuration: const Duration(seconds: 0),
                    suggestionsBoxVerticalOffset: 20,
                    hideOnEmpty: true,
                    keepSuggestionsOnLoading: true,
                    hideSuggestionsOnKeyboardHide: false,
                    noItemsFoundBuilder: (context) => const SizedBox(),
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white.withOpacity(0.9),
                      hasScrollbar: false,
                    ),
                    textFieldConfiguration: TextFieldConfiguration(
                      cursorColor: AppColors.backgroundColor.shade500,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        hintText: 'Type to search for certain city',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                    debounceDuration: const Duration(milliseconds: 500),
                    suggestionsCallback: (pattern) async =>
                        await HomeWeatherBloc.get(context).searchCity(pattern),
                    itemBuilder: (context, suggestion) {
                      final city = suggestion;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
                          minLeadingWidth: 10,
                          leading: const Icon(
                            Icons.location_on,
                            size: 22,
                            color: Colors.black87,
                          ),
                          title: Text(
                            city.name!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            '${(city.region! == '' ? '' : '${city.region!}, ')}${city.country!}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) async {
                      context.loaderOverlay.show(
                        widget: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                      await HomeWeatherBloc.get(context)
                          .addLocation(suggestion);
                      context.loaderOverlay.hide();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

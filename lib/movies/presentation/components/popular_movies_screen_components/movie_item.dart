import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_app/core/components/release_data.dart';
import 'package:cine_app/movies/domain/entities/movies.dart';
import 'package:flutter/material.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/global/app_navigation.dart';
import '../../../../core/global/app_styles.dart';
import '../../../../core/network/api_constants.dart';
import '../../screens/movie_details_screen.dart';
import '../movies_screen_components/shimmer_movies_list_view.dart';

class MovieItem extends StatelessWidget {
  final Movies movie;
  const MovieItem({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigation.navigateTo(
          context: context,
          screen: MovieDetailsScreen(id: movie.id),
        );
      },
      child: Card(
        color: AppColors.kPrimaryColor.withOpacity(0),
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10,
          ),
          child: FadeInUp(
            from: 30,
            duration: const Duration(milliseconds: 500),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 0.4 / 0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: ApiConstants.imageUrl(movie.backdropPath),
                        placeholder: (context, url) =>
                            const ShimmerMoviesListView(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        movie.title,
                        style: AppStyles.textStyle19.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: <Widget>[
                          ReleaseData(
                            color: Colors.redAccent,
                            releaseDate: movie.releaseDate,
                          ),
                          const SizedBox(width: 16.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20.0,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                (movie.voteAverage / 2).toStringAsFixed(1),
                                style: AppStyles.textStyle16.copyWith(
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        movie.overview,
                        style: AppStyles.textStyle14,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:themoviedb/data/models/movie_details_model/movie_details.dart';
import 'package:themoviedb/data/models/movie_model/movie.dart';
import 'package:themoviedb/data/models/movie_response_model/movie_response.dart';
import 'package:themoviedb/data/networking/movie_repository.dart';
import 'package:themoviedb/environment/enviroment.dart';
import 'fake_response.dart';
import 'movie_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  const _host = Environment.HOST;
  const _apiKey = Environment.API_KEY;

  group('Correct of movieRepository logic', () {
    final mockDio = MockDio();
    final movieRepository = MovieRepository(dio: mockDio);

    test('fetch movie', () async {
      const baseUrl = '$_host/movie/top_rated?api_key=$_apiKey';
      int page = 1;
      when(mockDio.get(
        baseUrl,
        queryParameters: <String, dynamic>{
          'page': page,
        },
      )).thenAnswer(
        (_) async => Response(
          data: fakeResponse,
          requestOptions: RequestOptions(
            path: baseUrl,
          ),
        ),
      );
      var movieList = await movieRepository.fetchMovie(page, 'top_rated');
      MovieResponse expectedResult = MovieResponse(
          page: 1,
          movies: [
            Movie(
                posterPath: "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
                adult: false,
                overview:
                    'From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.',
                releaseDate: "2016-08-03",
                genre_ids: const [14, 28, 80],
                id: 297761,
                originalTitle: "Suicide Squad",
                originalLanguage: "en",
                title: "Suicide Squad",
                backdropPath: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
                popularity: 48.261451,
                voteCount: 1466,
                video: false,
                voteAverage: 5.91)
          ],
          totalResults: 19629,
          totalPages: 982);

      expect(movieList, expectedResult);
    });

    test('get details movie', () async {
      int movieId = 19404;
      var url = '$_host/movie/$movieId?api_key=$_apiKey';
      when(mockDio.get(
        url,
      )).thenAnswer(
        (_) async => Response(
          data: fakeResponseMovieDetail,
          requestOptions: RequestOptions(path: url),
        ),
      );
      var movieDetail = await movieRepository.getMovieDetail(movieId);
      MovieDetails expectedMovieDetails = MovieDetails(
          adult: false,
          backdropPath: "/5hNcsnMkwU2LknLoru73c76el3z.jpg",
          belongsToCollection: null,
          budget: 13200000,
          genres: [
            Genre(id: 35, name: "Comedy"),
            Genre(id: 18, name: "Drama"),
            Genre(id: 10749, name: "Romance")
          ],
          homepage: "",
          id: 19404,
          imdbId: "tt0112870",
          originalLanguage: 'hi',
          originalTitle: "दिलवाले दुल्हनिया ले जायेंगे",
          overview:
              "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga.",
          popularity: 32.972,
          posterPath: "/2CAL2433ZeIihfX1Hb2139CX0pW.jpg",
          productionCompanies: [
            ProductionCompanie(
                id: 1569,
                logoPath: "/lvzN86o3jrP44DIvn4SMBLOl9PF.png",
                name: "Yash Raj Films",
                originCountry: "IN")
          ],
          productionCountries: [ProductionCountrie(iso: "IN", name: "India")],
          releaseDate: "1995-10-20",
          revenue: 100000000,
          runtime: 190,
          spokenLanguages: [
            SpokenLanguage(englishName: 'Hindi', iso: "hi", name: "हिन्दी")
          ],
          status: "Released",
          tagline: "Come Fall In love, All Over Again..",
          title: "Dilwale Dulhania Le Jayenge",
          video: false,
          voteAverage: 8.7,
          voteCount: 3430);

      expect(movieDetail, expectedMovieDetails);
    });
  });
}

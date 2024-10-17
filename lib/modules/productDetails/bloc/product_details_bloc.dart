import 'package:bloc/bloc.dart';
import 'package:cabswalle/modules/productDetails/bloc/product_details_event.dart';
import 'package:cabswalle/modules/productDetails/bloc/product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsInitial()) {
    on<ProductDetailsEvent>((event, emit) {});
  }
}

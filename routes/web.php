<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
 */

Route::get('/', 'HomeController@index')->name('home');

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

Route::get('/quan-ly.html', 'ManagerController@index')->name('auth.manager');

Route::post('change-password', 'ManagerController@changePassword')->name('change.password');

// Admin voyager route
Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();
});

Route::group(['prefix' => 'admin/'], function () {
    Route::get('products/{id}/attribute', 'Admin\ProductController@getattribute')->name('admin.product.attribute');
    Route::get('products/{id}/attribute', 'Admin\ProductController@getattribute')->name('admin.product.attribute.detail');
    Route::post('products/{id}/attribute', 'Admin\ProductController@postattribute')->name('admin.product.attribute');
    Route::get('product-attribute/{id}', 'ProductController@productAttribute')->name('product.attibute.detail');
    Route::get('product-attribute/edit/{id}', 'Admin\ProductController@getProductAttributeValueByAttributeId')->name('product.attibute.value.detail');
    Route::post('product-attribute/edit/{id}', 'Admin\ProductController@postProductAttributeValueByAttributeId')->name('product.attibute.value.detail');
    Route::delete('product-attribute/{__id}', 'Admin\ProductController@deteleAttribute')->name('product.attibute.value.delete');
    //Orders
    Route::get('order/confirm/{id}', 'Admin\OrderController@confirm')->name('admin.orders.confirm');
});

// Ajax get product attibute

Route::get('product-attribute/{id}', 'ProductController@productAttribute')->name('product.attribute.detail');



// Giỏ hàng
Route::group(['prefix' => '/'], function () {
    Route::get('gio-hang.html', 'CartController@index')->name('cart.index');
    Route::post('add', 'CartController@store')->name('cart.add');
    Route::get('destroy', 'CartController@destroy')->name('cart.destroy');
    Route::get('remove/{rowId}', 'CartController@remove')->name('cart.remove');
    Route::get('update/{rowId}/{qty}', 'CartController@update')->name('cart.update');
    Route::get('updatecolor/{id}/{rowId}/{qty}/{color}/{unit}', 'CartController@updateColor')->name('cart.updatecolor');
    Route::get('xac-nhan-dat-hang.html', 'CheckoutController@index')->name('checkout.index');
    Route::post('xac-nhan.html', 'CheckoutController@store')->name('checkout.store');
    Route::get('thay-doi-{rowId}.html', 'CartController@updateItemCart')->name('cart.updateitemcart');

    Route::get('don-hang/{id}.html', 'ManagerController@orderDetail')->name('order.detail');

    Route::get('don-hang-khong-tim-thay.html', 'ManagerController@orderDetail')->name('order.erro');

    Route::get('s/{slug}.html', 'ProductController@detail')->name('product.detail');

    Route::get('san-pham-hot.html', 'ProductController@hotProducts')->name('product.hot');

    Route::get('san-pham-moi.html', 'ProductController@newProducts')->name('product.new');

    Route::get('tim-kiem.html', 'SearchController@search')->name('product.search');

    Route::get('{slug}', 'ProductController@product_cate')->name('product.cate');
});

Route::get('/success', 'CheckoutController@success')->name('checkout.success');

Route::get('/email/verify', function () {
  return view('auth.verify');
})->middleware('auth')->name('verification.verify');

Auth::routes(['verfiy' => true]);
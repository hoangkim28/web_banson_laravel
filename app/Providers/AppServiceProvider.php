<?php

namespace App\Providers;

use App\Models\Brand;
use Illuminate\Support\ServiceProvider;
use App\Models\Cart;
use App\Models\Category;
use App\Models\Slide;
use App\Models\Product;
use Session;
use Validator;

use TCG\Voyager\Facades\Voyager;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        view()->composer(['layouts.nav','product.search','product.category'], function ($toView) {
            $Category = Category::all()->where('status','=',1);
            $Brand = Brand::all()->where('status','=',1);
            $keyword = '';
            $toView->with('Categories', $Category)
                ->with('keyword',$keyword)
            ->with('Brand',$Brand);
        });
        
        Voyager::addAction(\App\Actions\Order\OrderConfirmAction::class);

        Validator::extend('phone', function($attribute, $value, $parameters, $validator) {
          return preg_match('%^(?:(?:\(?(?:00|\+)([1-4]\d\d|[1-9]\d?)\)?)?[\-\.\ \\\/]?)?((?:\(?\d{1,}\)?[\-\.\ \\\/]?){0,})(?:[\-\.\ \\\/]?(?:#|ext\.?|extension|x)[\-\.\ \\\/]?(\d+))?$%i', $value) && strlen($value) >= 10;
        });
        
        Validator::replacer('phone', function($message, $attribute, $rule, $parameters) {
          return str_replace(':attribute',$attribute, ':attribute is invalid phone number');
        });

    }
}

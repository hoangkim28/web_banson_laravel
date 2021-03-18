<?php

namespace App\Providers;

use App\Models\Brand;
use Illuminate\Support\ServiceProvider;
use App\Models\Cart;
use App\Models\Category;
use App\Models\Slide;
use App\Models\Product;
use Session;

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

    }
}

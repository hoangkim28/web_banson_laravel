<?php

namespace App\Widgets;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use TCG\Voyager\Facades\Voyager;
use Carbon\Carbon;
use DB;

class RevenueDimmer extends BaseDimmer
{
    /**
     * The configuration array.
     *
     * @var array
     */
    protected $config = [];

    /**
     * Treat this method as a controller action.
     * Return view() or other content to display.
     */
    public function run()
    {
        $start = (new Carbon('first day of this month'))->toDateString();
        $end = (new Carbon('last day of this month'))->toDateString();
        $value = DB::select(
            'call GetRevenueDaily(?,?)',
            array($start,$end)
        );
        // $string = '';

        // foreach($value as $a)
        // {    
        //     foreach($a as $b=>$c)
        //     {
        //         $string .= $c.',';
        //     }
        // }

        // $solution = substr($string,0,-1);
        $revenue = 0;
        $profit = 0;
        foreach($value as $item){
            $revenue+=$item->Revenue;
            $profit+=$item->Profit;
        }
        $revenue = format($revenue);
        $profit = format($profit);
        return view('vendor.dimmer.revenue', array_merge($this->config, [
            'icon'   => 'voyager-bag',
            'title'  => "Doanh thu",
            'text'   => $revenue . ' VND',
            'title2'  => "Lợi nhuận",
            'text2'   => $profit . ' VND',
            'button' => [
                'text' => __('Xem'),
                'link' => route('voyager.orders.index')
            ],
            'image' => '',
        ]));
    }

    /**
     * Determine if the widget should be displayed.
     *
     * @return bool
     */
    public function shouldBeDisplayed()
    {
        return Auth::user()->can('browse', Voyager::model('User'));
    }
}

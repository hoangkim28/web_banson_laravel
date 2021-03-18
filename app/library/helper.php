<?php

function format($price) {
    return number_format($price, 0);
}

function str_limit($string, $limit) {
    return strlen($string) > $limit ? substr($string, 0, $limit) . ' ...' : $string;
}

function get_promotion_price($product) {
    return number_format($product->price - $product->price*$product->promotion/100, 0);
}

function get_last_price($product) {
    return ($product->price - $product->price*$product->promotion/100);
}

function getStockLevel($quantity) {
    if($quantity > setting('site.stock_threshold')) {
        return 'In Stock';
    } else if($quantity <= setting('site.stock_threshold') && $quantity > 0) {
        return 'Low Stock';
    } else {
        return 'Out Of Stock';
    }
}

<?php

namespace App\Actions\Order;

use TCG\Voyager\Actions\AbstractAction;

class OrderConfirmAction extends AbstractAction {

    public function getTitle() {
        return 'Xác nhận';
    }

    public function getIcon() {
        return 'voyager-check';
    }

    public function getPolicy()
    {
        return 'edit';
    }

    public function getAttributes() {
        //Action button classes
        $style = "none";
        $order = \App\Models\Order::where('id','=',$this->data->id)->first();
        if($order->order_status != 4)
        {
            $style = "block";
        }
        return [
            'class' => 'btn btn-sm btn-success pull-right confirm',
            'style' => 'display:' . $style,
        ];
    }

    public function shouldActionDisplayOnDataType() {
        //Display this action only for the orders
        return $this->dataType->slug === 'orders';
    }

    public function getDefaultRoute() {
        return route('admin.orders.confirm', ['id'=>$this->data->id]);
    }
}
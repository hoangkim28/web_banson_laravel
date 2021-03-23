<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use App\Models\OrderDetail;
use App\Models\Order;

class CheckoutNotify extends Notification
{
    use Queueable;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed  $orderId
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($orderId)
    {
        $bill = Order::where('id', '=', $orderId)->first();
        $billDetail = OrderDetail::where('order_id', '=', $orderId)->get();
        return (new MailMessage)
            ->subject('Thành Tánh - Theo dõi đơn hàng')
            ->view('notify.order', ['bill' => $bill, 'billDetail' => $billDetail]);
    }

    /**
     * Get the array representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function toArray($notifiable)
    {
        return [
            //
        ];
    }
}

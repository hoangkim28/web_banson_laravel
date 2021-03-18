<?php

namespace App\Notifications;

use App\Models\Bill;
use App\Models\OrderDetail;
use App\Models\Order;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class OrderNotify extends Notification
{
    use Queueable;
    protected $bill;
    protected $billDetail;
    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct($bill, $billDetail)
    {
        $this->bill = $bill;
        $this->billDetail = $billDetail;
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
     * @param  mixed  $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($notifiable)
    {

        return (new MailMessage)
            ->subject('Thành Tánh - Theo dõi đơn hàng')
            // ->view('notify.order')
            // ->with(['bill' => $this->bill, 'billDetail' => $this->billDetail]);
            ->markdown('notify.order', [
                'bill' => $this->bill,
                'billDetail' => $this->billDetail,
            ]);
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

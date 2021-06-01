<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateOrdersTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'orders';

    /**
     * Run the migrations.
     * @table orders
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->bigInteger('user_id')->unsigned()->nullable()->default(null);
            $table->string('full_name', 100)->nullable()->default(null);
            $table->string('address1', 150);
            $table->string('address2', 150)->nullable()->default(null);
            $table->integer('phone');
            $table->string('email', 100);
            $table->string('comment')->nullable()->default(null);
            $table->integer('payment_method')->unsigned()->nullable()->default(null);
            $table->integer('order_status')->unsigned()->nullable()->default(null);
            $table->mediumText('subtotal')->nullable()->default(null);
            
            $table->mediumText('total')->nullable()->default(null);
            $table->nullableTimestamps();

            $table->foreign('payment_method')->references('id')->on('payment_methods');
            $table->foreign('order_status')->references('id')->on('order_statuses');
            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists($this->tableName);
    }
}

<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBillsTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $tableName = 'bills';

    /**
     * Run the migrations.
     * @table bills
     *
     * @return void
     */
    public function up()
    {
        Schema::create($this->tableName, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->bigIncrements('id');
            $table->bigInteger('user_id')->nullable()->default(null);
            $table->string('full_name', 100)->nullable()->default(null);
            $table->string('email', 100)->nullable()->default(null);
            $table->integer('phone')->nullable()->default(null);
            $table->string('address1', 150)->nullable()->default(null);
            $table->string('address2', 150)->nullable()->default(null);
            $table->integer('comment')->nullable()->default(null);
            $table->integer('payment_method')->nullable()->default(null);
            $table->mediumText('subtotal')->nullable()->default(null);
            $table->mediumText('tax')->nullable()->default(null);
            $table->mediumText('total')->nullable()->default(null);
            $table->nullableTimestamps();
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

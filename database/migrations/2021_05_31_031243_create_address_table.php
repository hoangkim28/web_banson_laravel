<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAddressTable extends Migration
{
  public $tableName = 'address';
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
      Schema::create($this->tableName, function (Blueprint $table) {
        $table->id();
        $table->bigInteger('user_id')->unsigned()->nullable()->default(null);
        $table->string('address', 100);
        $table->string('phone', 100);
        $table->timestamps();

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
        Schema::dropIfExists($tableName);
    }
}

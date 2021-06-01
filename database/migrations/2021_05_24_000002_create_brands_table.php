<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBrandsTable extends Migration
{

    public $tableName = 'brands';

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
      Schema::create($this->tableName, function (Blueprint $table) {
        $table->engine = 'InnoDB';
        $table->bigIncrements('id');
        $table->string('name', 100);
        $table->string('slug', 100);
        $table->string('image', 150)->nullable()->default(null);
        $table->string('website', 100);        
        $table->tinyInteger('status')->default('0');
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
        Schema::dropIfExists('brands');
    }
}
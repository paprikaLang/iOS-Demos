//
//  ArrayScene.swift
//  Tetrominos
//
//  Created by paprika on 2017/11/12.
//  Copyright © 2017年 paprika. All rights reserved.
//
class ArrayScene<T> {
    let columns:Int
    let rows:Int
    
    var array: Array<T?>
    
    init(columns: Int,rows: Int){
        self.columns = columns
        self.rows = rows
        array = Array<T?>(repeating:nil,count:columns * rows)
        //print(array)
    }
    subscript(column:Int,row:Int)->T?{
        get{
            return array[(row*columns)+column]
        }
        set(newValue){
            array[(row*columns)+column] = newValue
        }
    }
}

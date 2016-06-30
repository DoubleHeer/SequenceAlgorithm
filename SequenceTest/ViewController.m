//
//  ViewController.m
//  SequenceTest
//
//  Created by heer on 16/5/27.
//  Copyright © 2016年 heer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[@3,@1,@11,@87,@4,@5,@15,@16,@17,@18];
    NSMutableArray *mutable = [NSMutableArray arrayWithArray:arr];
   // NSMutableArray *temp = [NSMutableArray array];
   // [self QuickSort:mutable StartIndex:0 EndIndex:mutable.count-1];
    //[self InsertSort:mutable];
    //[self BinaryInsertSort:mutable];
    //[self shellSort:mutable];
    //[self HeapSort:mutable];
    //[self BinarySelectSort:mutable];
    
   arr = [self mergeSortWithArray:arr];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//快排算法
//特性：unstable sort、In-place sort。
//最坏运行时间：当输入数组已排序时，时间为O(n^2)，当然可以通过随机化来改进（shuffle array 或者 randomized select pivot）,使得期望运行时间为O(nlgn)。
//最佳运行时间：O(nlgn)
//快速排序的思想也是分治法。
//随即取 当前取第一个，首先找到第一个的位置，然后根据比其本身大或者小分成left和right两组子集 ，分别对left和right继续执行分割(同上操作)
-(void)QuickSort:(NSMutableArray *)list StartIndex:(NSInteger)startIndex EndIndex:(NSInteger)endIndex{
    
    if(startIndex >= endIndex) return;
    
    NSNumber * temp = [list objectAtIndex:startIndex];
    NSInteger tempIndex = startIndex; //临时索引 处理交换位置(即下一个交换的对象的位置)
    
    for(NSInteger i = startIndex + 1 ; i <= endIndex ; i++){
        
        NSNumber *t = [list objectAtIndex:i];//此处若为字典等，可再取key进行比较
        
        if([temp intValue] > [t intValue]){
            
            tempIndex = tempIndex + 1;
            
            [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:i];
            
        }
        
    }
    
    [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:startIndex];
    [self QuickSort:list StartIndex:startIndex EndIndex:tempIndex-1];
    [self QuickSort:list StartIndex:tempIndex+1 EndIndex:endIndex];
    
}



//冒泡排序算法
//取第一个 与其邻接的对比，若大则交换
//特点：stable sort、In-place sort
//思想：通过两两交换，像水中的泡泡一样，小的先冒出来，大的后冒出来。
//最坏运行时间：O(n^2)
//最佳运行时间：O(n^2)（当然，也可以进行改进使得最佳运行时间为O(n)）
-(void)BubbleSort:(NSMutableArray *)list{
    
    for (int j = 1; j<= [list count]; j++) {
        for(int i = 0 ;i < j ; i++) {
            if(i == [list count]-1)return;
            
            NSInteger a1 = [[list objectAtIndex:i] intValue];
            NSInteger a2 = [[list objectAtIndex:i+1] intValue];
            
            if(a1 > a2){
                [list exchangeObjectAtIndex:i withObjectAtIndex:i+1];
            }
            
        }
        
    }
    
}
//改进版冒泡排序
//最佳运行时间：O(n)
//最坏运行时间：O(n^2)
-(void)BubbleSortBetter:(NSMutableArray *)list{
    BOOL exchange = YES;
    for (int j = 1; j<= [list count]; j++) {
        if (exchange == NO ) return;//当某一次循环没有数据交换，说明是有序的了，可直接退出循环
        exchange = NO;
        for(int i = 0 ;i < j ; i++) {
            if(i == [list count]-1)return;
            
            NSInteger a1 = [[list objectAtIndex:i] intValue];
            NSInteger a2 = [[list objectAtIndex:i+1] intValue];
            
            if(a1 > a2){
                [list exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                exchange = YES;
            }
            
        }
        
    }
    
}

//直接插入排序
//从无序表中取出第一个元素，插入到有序表的合适位置，使有序表仍然有序
//取出第一个与第0个比较后按序排，再取第二个与第一个比，若小再与第一个比，按序排，再取第三个...

//特点：stable sort、In-place sort
//最优复杂度：当输入数组就是排好序的时候，复杂度为O(n)，而快速排序在这种情况下会产生O(n^2)的复杂度。
//最差复杂度：当输入数组为倒序时，复杂度为O(n^2)
//插入排序比较适合用于“少量元素的数组”。
-(void)InsertSort:(NSMutableArray *)list {
    
    for(int i = 1 ; i < [list count] ; i++) {
        
        int j = i;
        NSInteger temp= [[list objectAtIndex:i] intValue];
        
        while (j > 0 && temp < [[list objectAtIndex:j - 1]intValue]) {
            
            [list replaceObjectAtIndex:j withObject:[list objectAtIndex:(j-1)]];
            //list[j] = list[j-1];
            j--;
            
        }
        [list replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
        //list[j] = temp;
        
    }
    
}

//折半插入排序
//从无序表中取出第一个元素，利用折半查找插入到有序表的合适位置，使有序表仍然有序
//原理同上，取第10个与第5个比较，若小，则与第3个比较，若大，则与第4个比较，按序排好
-(void)BinaryInsertSort:(NSMutableArray *)list{
    
    //索引从1开始 默认让出第一元素为默认有序表 从第二个元素开始比较
    for(int i = 1 ; i < [list count] ; i++){
        
        //binary search start
        NSInteger temp= [[list objectAtIndex:i] intValue];
        
        int left = 0;
        int right = i - 1;
        
        while (left <= right) {
            
            int middle = (left + right)/2;
            
            if(temp < [[list objectAtIndex:middle] intValue]){
                
                right = middle - 1;
                
            }else{
                
                left = middle + 1;
                
            }
            
        }
        //binary search end
        
        //移动3,5,6,[4] 4是当前目标对象 利用binarysearch 找到4应该在有续集{3,5,6}的位置，然后向后移动即{3,5,6,[4]}-->{3,[4],5,6}
        for(int j = i ; j > left; j--){
            
            [list replaceObjectAtIndex:j withObject:[list objectAtIndex:j-1]];
            
        }
        [list replaceObjectAtIndex:left withObject:[NSNumber numberWithInteger:temp]];
        
    }
    
    
}

//希尔排序
//对直接插入排序优化，创造一个gap来对表进行分割，对分割后的每个子集进行直接插入排序 直到gap＝＝1结束
//通过gap一层层往下，使序列基本有序，最后用直接排序
-(void)shellSort:(NSMutableArray *)list{
    NSInteger gap = [list count] / 2;
    
    while (gap >= 1) {
        
        for(NSInteger i = gap ; i < [list count]; i++){
            
            NSInteger temp = [[list objectAtIndex:i] intValue];
            NSInteger j = i;
            
            while (j >= gap && temp < [[list objectAtIndex:(j - gap)] intValue]) {
                [list replaceObjectAtIndex:j withObject:[list objectAtIndex:j-gap]];
                j -= gap;
            }
            [list replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
            
            
        }
        
        gap = gap / 2;
    }
    
    
}

//堆排序
//每次执行最大堆(索引要前移动 即排除已经排好的最大堆头元算 交换到list尾部的这个元素)
-(void)HeapSort:(NSMutableArray *)list{
    
    [self CreateBiggestHeap:list Count:[list count]];
    for(NSInteger i = [list count]-1 ; i > 0; i--){
        
        [list exchangeObjectAtIndex:i withObjectAtIndex:0];
        
        [self heapAdJust:list andBegin:0 Count:i];

    }
    
}

//创建初始化   最大堆heap 最大／最小优先级队列
-(void)CreateBiggestHeap:(NSMutableArray *)list Count:(NSInteger)count{
    
    NSInteger lastParentIndex = (count - 2)/2;
    for (NSInteger i = lastParentIndex; i >= 0; i--) {
         [self heapAdJust:list andBegin:i Count:count];
    }
   
}

//设置堆
- (void)heapAdJust:(NSMutableArray *)list andBegin:(NSInteger)i Count:(NSInteger)count {
   
        NSInteger parentIndex = i;
        NSInteger parentNode = [[list objectAtIndex:parentIndex] intValue];
    
        //获取左子结点为当前子结点
        NSInteger currentChildIndex = 2*i + 1;
        //
        while (currentChildIndex <= count - 1) {
            
            NSInteger leftChildNode = [[list objectAtIndex:(currentChildIndex)] intValue];
            
            if((currentChildIndex + 1) <= count-1){//表示存在右子结点
                
                //读取右子结点
                NSInteger rightChildIndex =currentChildIndex + 1;
                NSInteger rightChildNode = [[list objectAtIndex:(rightChildIndex)] intValue];
                
                //如果右子结点为最大
                if(rightChildNode > leftChildNode && rightChildNode > parentNode){
                    [list exchangeObjectAtIndex:parentIndex withObjectAtIndex:rightChildIndex];
                    currentChildIndex = rightChildIndex;//右子结点为当前子结点 继续循环
                    
                }
                else if(leftChildNode > rightChildNode && leftChildNode > parentNode){//左子结点最大
                    [list exchangeObjectAtIndex:parentIndex withObjectAtIndex:currentChildIndex];
                }
                
            }else{
                
                if(leftChildNode > parentNode){
                    [list exchangeObjectAtIndex:parentIndex withObjectAtIndex:currentChildIndex];
                    
                }
                
            }
            //更新父结点和下一个子结点
            parentIndex = currentChildIndex;
            currentChildIndex = 2*currentChildIndex + 1;
            
        }
    
}

//直接选择排序
//特性：In-place sort，unstable sort。
//思想：每次找一个最小值。
//最好情况时间：O(n^2)。
//最坏情况时间：O(n^2)。
//在对象集中选出最小的 若不是第一个 则与第一个交换 在剩余的对象集中选出最小的 执行前面的步骤
-(void)SelectSort:(NSMutableArray *)list{
    
    for(int i = 0 ; i<[list count]; i++){
        
        int k = i;
        for(int j = i+1 ; j<[list count]; j++){
            
            NSInteger jvalue = [[list objectAtIndex:j] intValue];
            NSInteger kvalue = [[list objectAtIndex:k] intValue];
            
            if(jvalue < kvalue){
                k = j;
            }
            
        }
        if(k != i){
            [list exchangeObjectAtIndex:i withObjectAtIndex:k];
        }
        
    }
    
}

//二元选择排序 对直接选择排序优化，每次选出最大和最小的两个值，
-(void)BinarySelectSort:(NSMutableArray *)list{
    
    for(int i = 0 ; i<[list count]/2; i++){
        
        int min = i, max = i;
        for(int j = i+1 ; j< [list count]-i; j++){
            
            NSInteger jvalue = [[list objectAtIndex:j] integerValue];
            NSInteger minvalue = [[list objectAtIndex:min] integerValue];
            NSInteger maxvalue = [[list objectAtIndex:max] integerValue];
            if(jvalue < minvalue){
                min = j;
            }
            if (jvalue > maxvalue) {
                max = j;
            }
            
        }
        if(max != i){
            [list exchangeObjectAtIndex:[list count]-1-i withObjectAtIndex:max];
        }
        if (min != i) {
            [list exchangeObjectAtIndex:i withObjectAtIndex:min];
                   }
        
    }
    
}



//归并排序
//其的基本思路就是将数组分成二组A，B，如果这二组组内的数据都是有序的，那么就可以很方便的将这二组数据进行排序。
//  先分 将数组分成两组，递归，直到只有一个数，则可认为该数组有序
- (NSArray *)mergeSortWithArray: (NSArray *)array
{
    if (array.count <= 1)
    {
        return array;
    }
    
    NSInteger _number = array.count/2;
    NSArray *_leftArray = [self mergeSortWithArray:
                           [array subarrayWithRange:NSMakeRange(0, _number)]];
    
    NSArray *_rightArray = [self mergeSortWithArray:
                            [array subarrayWithRange:NSMakeRange(_number, array.count-_number)]];
    
    return [self mergeWithLeftArray:_leftArray rightArray:_rightArray];
}

//OC 归并排序 主程 后合 只要从比较二个数列的第一个数，谁小就先取谁，取了后就在对应数列中删除这个数。然后再进行比较，如果有数列为空，那直接将另一个数列的数据依次取出即可。
- (NSArray *)mergeWithLeftArray: (NSArray *)leftArray rightArray: (NSArray *)rightArray
{
    int l = 0;
    int r = 0;
    NSMutableArray *_resultArray = [NSMutableArray array];
    
    while (l < leftArray.count &&
           r < rightArray.count)
    {
        if (leftArray[l] < rightArray[r])
        {
            [_resultArray addObject:leftArray[l]];
            l++;
        }
        else
        {
            [_resultArray addObject:rightArray[r]];
            r++;
        }
    }
    while (l < leftArray.count)
        [_resultArray addObject:leftArray[l++]] ;
    
    while (r < rightArray.count)
        [_resultArray addObject:rightArray[r++]];
    
    //[_resultArray addObject: (leftArray.lastObject > rightArray.lastObject)?leftArray.lastObject:rightArray.lastObject];//当某一组还有多个元素时会丢失数据
    
    return _resultArray;
}
@end

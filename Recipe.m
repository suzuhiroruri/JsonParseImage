//
//  Recipe.m
//  foody
//
//  Created by Tope on 04/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
//URLをロードしてインスタンスに格納するメソッド

#import "Recipe.h"

@implementation Recipe

@synthesize name;
@synthesize thumbNail;
@synthesize twitterShareCount;
@synthesize imageData;


//urlからイメージデータをロードする
-(void)loadData
{
    NSURL* url = [NSURL URLWithString:self.thumbNail];
    self.imageData = [NSData dataWithContentsOfURL:url];
}

@end

//
//  ViewController.m
//  MRAPolarChart
//
//  Created by MUHAMMAD RISHAD ALI on 19/06/2014.
//  Copyright (c) 2014 rishad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize data = _data;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"18.45,10.3,7.74,4.02,0.0,0.0,0.0,340.0"];
    [array addObject:@"17.5,10.3,7.57,4.18,0.0,0.0,0.0,270.0"];
    [array addObject:@"19.0,11.1,8.58,4.45,0.0,0.0,0.0,180.0"];
    [array addObject:@"15.9,9.8,8.27,4.5,0.0,0.0,0.0,0.0"];
    [array addObject:@"20.1,11.6,8.98,4.64,0.0,0.0,0.0,85.0"];
    [array addObject:@"18.1,11.3,8.77,4.49,0.0,0.0,0.0,15.0"];
    [array addObject:@"20.3,11.4,9.23,4.58,0.0,0.0,0.0,315.0"];
    [array addObject:@"21.9,11.0,8.71,4.37,0.0,0.0,0.0,125.0"];
    [array addObject:@"17.3,9.6,7.21,4.05,0.0,0.0,0.0,45.0"];
    [array addObject:@"16.1,9.3,7.67,4.25,0.0,0.0,0.0,15.0"];
    [array addObject:@"16.0,9.2,7.26,3.82,0.0,0.0,0.0,30.0"];
    [array addObject:@"14.9,9.1,7.09,3.94,0.0,0.0,0.0,60.0"];

    self.data = array;
}



- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [rc removeFromSuperview];

    CGFloat chartSize = 320;
    CGFloat chartXPosition = 0;
    CGFloat chartYPosition = 5;

    
    if(self.view.frame.size.width<self.view.frame.size.height)
    {
        chartSize = self.view.frame.size.width;
    }
    else
    {
        chartSize = self.view.frame.size.height;
    }

    rc = [[MRAPolarChart alloc] initWithFrame:CGRectMake(chartXPosition, chartYPosition, chartSize, chartSize)];

    rc.backLineWidth = 0.5f;
    rc.frontLineWidth = 1.5f;
    rc.dotRadius = 3;

    rc.showValues = YES;
    rc.showGuideNumbers = YES;
    rc.drawGuideLines = YES;
    rc.fillArea = YES;

    self.view.backgroundColor = [UIColor whiteColor];

    rc.backgroundColor = [UIColor whiteColor];

    rc.colors = [[NSArray alloc] initWithObjects:[UIColor blueColor],[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],[UIColor cyanColor],[UIColor orangeColor],[UIColor magentaColor],[UIColor purpleColor],nil];

    [self drawPolarChart];

    [self.view addSubview:rc];

}


- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

    [rc removeFromSuperview];

    CGFloat chartSize = 320;
    CGFloat chartXPosition = 0;
    CGFloat chartYPosition = 5;

    if(self.view.frame.size.width<self.view.frame.size.height)
    {
        chartSize = self.view.frame.size.width;
    }
    else
    {
        chartSize = self.view.frame.size.height;
    }

    rc = [[MRAPolarChart alloc] initWithFrame:CGRectMake(chartXPosition, chartYPosition, chartSize, chartSize)];

    rc.backLineWidth = 0.5f;
    rc.frontLineWidth = 1.5f;
    rc.dotRadius = 3;

    rc.showValues = YES;
    rc.showGuideNumbers = YES;
    rc.drawGuideLines = YES;
    rc.fillArea = NO;
    rc.backgroundColor = [UIColor whiteColor];

    rc.colors = [NSArray arrayWithObjects:[UIColor blueColor],[UIColor redColor],[UIColor yellowColor],[UIColor greenColor], [UIColor greenColor],nil];

    [self drawPolarChart];

    [self.view addSubview:rc];


}

-(NSMutableArray *)getSortedData
{
    int size = (int)self.data.count;

    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:size];

    for (int i = 0; i<size; i++)
    {
        NSString *dataStr = [self.data objectAtIndex:i];
        NSNumber *val0 = [NSNumber numberWithDouble:[[[dataStr componentsSeparatedByString:@","] objectAtIndex:0] doubleValue]];
        NSNumber *val1 = [NSNumber numberWithDouble:[[[dataStr componentsSeparatedByString:@","] objectAtIndex:1] doubleValue]];
        NSNumber *val2 = [NSNumber numberWithDouble:[[[dataStr componentsSeparatedByString:@","] objectAtIndex:2] doubleValue]];
        NSNumber *val3 = [NSNumber numberWithDouble:[[[dataStr componentsSeparatedByString:@","] objectAtIndex:3] doubleValue]];
        NSNumber *val4 = [NSNumber numberWithDouble:[[[dataStr componentsSeparatedByString:@","] objectAtIndex:4] doubleValue]];
        NSNumber *val5 = [NSNumber numberWithDouble:[[[dataStr componentsSeparatedByString:@","] objectAtIndex:5] doubleValue]];
        NSNumber *val6 = [NSNumber numberWithDouble:[[[dataStr componentsSeparatedByString:@","] objectAtIndex:6] doubleValue]];
        NSNumber *val7 = [NSNumber numberWithDouble:[[[dataStr componentsSeparatedByString:@","] objectAtIndex:7] doubleValue]];
        
        NSMutableDictionary *dataRow = [[NSMutableDictionary alloc] initWithCapacity:8];
        [dataRow setObject:val0 forKey:@"ch1"];
        [dataRow setObject:val1 forKey:@"ch2"];
        [dataRow setObject:val2 forKey:@"ch3"];
        [dataRow setObject:val3 forKey:@"ch4"];
        [dataRow setObject:val4 forKey:@"ch5"];
        [dataRow setObject:val5 forKey:@"ch6"];
        [dataRow setObject:val6 forKey:@"ch7"];
        [dataRow setObject:val7 forKey:@"ch8"];
        
        [array addObject:dataRow];
    }
    
    return array;
}

-(void)drawPolarChart
{
    NSMutableArray *sortedData = [self getSortedData];
    int size = (int)sortedData.count;
    
    NSMutableDictionary *chartData = [[NSMutableDictionary alloc] initWithCapacity:size];
    NSMutableDictionary *series0Data = [[NSMutableDictionary alloc] initWithCapacity:size];
    NSMutableDictionary *series1Data = [[NSMutableDictionary alloc] initWithCapacity:size];
    NSMutableDictionary *series2Data = [[NSMutableDictionary alloc] initWithCapacity:size];
    NSMutableDictionary *series3Data = [[NSMutableDictionary alloc] initWithCapacity:size];
    
    for (int i = 0; i<size; i++)
    {
        [series0Data setObject:[[NSArray alloc] initWithObjects:[[sortedData objectAtIndex:i] objectForKey:@"ch1"],[[sortedData objectAtIndex:i] objectForKey:@"ch8"], nil] forKey:[NSString stringWithFormat:@"row%i",i]];
        [series1Data setObject:[[NSArray alloc] initWithObjects:[[sortedData objectAtIndex:i] objectForKey:@"ch2"],[[sortedData objectAtIndex:i] objectForKey:@"ch8"], nil] forKey:[NSString stringWithFormat:@"row%i",i]];
        [series2Data setObject:[[NSArray alloc] initWithObjects:[[sortedData objectAtIndex:i] objectForKey:@"ch3"],[[sortedData objectAtIndex:i] objectForKey:@"ch8"], nil] forKey:[NSString stringWithFormat:@"row%i",i]];
        [series3Data setObject:[[NSArray alloc] initWithObjects:[[sortedData objectAtIndex:i] objectForKey:@"ch4"],[[sortedData objectAtIndex:i] objectForKey:@"ch8"], nil] forKey:[NSString stringWithFormat:@"row%i",i]];
    }
    [chartData setValue:series0Data forKey:[NSString stringWithFormat:@"DataSet-%d",0]];
    [chartData setValue:series1Data forKey:[NSString stringWithFormat:@"DataSet-%d",1]];
    [chartData setValue:series2Data forKey:[NSString stringWithFormat:@"DataSet-%d",2]];
    [chartData setValue:series3Data forKey:[NSString stringWithFormat:@"DataSet-%d",3]];
    
    rc.values = chartData;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

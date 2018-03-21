//
//  JusaBluetouth.h
//  Niaoji
//
//  Created by IOS App on 17/1/6.
//  Copyright © 2017年 nova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol JusaBluetoothManagerDelegate

@required
- (void)didGetDataForString:(NSString *)dataString Code:(NSString*)code;

@end

@interface JusaBluetouth : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>{
    CBCentralManager *manager;
    id<JusaBluetoothManagerDelegate> delegate;
    NSString *result;

    int indexOfniaoji;
    NSString *dataniaoji;
    
}

@property BOOL isConnected;
@property (retain, nonatomic) id<JusaBluetoothManagerDelegate> delegate;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic,copy) NSString *type;

- (void)writeToPeripheral:(NSString *)dataString;
- (instancetype)init:(NSString*)type;



@end

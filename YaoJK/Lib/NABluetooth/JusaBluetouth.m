//
//  JusaBluetouth.m
//  Niaoji
//
//  Created by IOS App on 17/1/6.
//  Copyright © 2017年 nova. All rights reserved.
//



#import "JusaBluetouth.h"

@interface JusaBluetouth()

@property (strong,nonatomic) NSMutableArray *peripherals;   //连接的外围设备
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;

@end

@implementation JusaBluetouth
@synthesize delegate=delegate;



- (instancetype)init:(NSString*)type{
    self = [super init];
    if (self) {
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        manager.delegate = self;
        _isConnected = NO;
        self.type = type;
    }
    return self;
}

    

- (void)writeToPeripheral:(NSString *)dataString {
    if(_writeCharacteristic == nil){
        NSLog(@"writeCharacteristic 为空");
        return;
    }
    NSData *value = [self dataWithHexstring:dataString];
    [_peripheral writeValue:value forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

#pragma mark - CBPeripheral Delegate

// 发现外设后
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    [self postBlueChange:@"寻找设备中"];
    if ([_type isEqualToString:@"taixin"]){
        if ([peripheral.name isEqualToString:@"VCMF"] || [peripheral.name isEqualToString:@"iFM"] || [peripheral.name isEqualToString:@"LCeFM"]) {
            [self connet:peripheral];
            
        }
        [self connet:peripheral];
    }
    if ([_type isEqualToString:@"tizhong"]){
        if ([peripheral.name isEqualToString:@"NOVABW_LE"] || [peripheral.name isEqualToString:@"AUTODA"]) {
            [self connet:peripheral];
        }
    }
    if ([_type isEqualToString:@"tiwen"]){
        if ([peripheral.name isEqualToString:@"HTD02"] || [peripheral.name isEqualToString:@"HC-08"]) {
            [self connet:peripheral];
        }
    }
    if ([_type isEqualToString:@"xueyang"]){
        if ([peripheral.name isEqualToString:@"BerryMed"] || [peripheral.name isEqualToString:@"NOVABT_LE"] || [peripheral.name isEqualToString:@"POD"]) {
            [self connet:peripheral];
        }
    }
    if ([_type isEqualToString:@"xueya"]){
        if ([peripheral.name isEqualToString:@"Yuwell BloodPressure"] || [peripheral.name isEqualToString:@"BPM-188"] ||[peripheral.name isEqualToString:@"H.HOME BP"]) {
            [self connet:peripheral];
            NSLog(@"xueya == %@",peripheral.name);
        }
    }
    if ([_type isEqualToString:@"xuetang"]){
        if ([peripheral.name isEqualToString:@"NOVABG_LE"]) {
            [self connet:peripheral];
        }
    }
    
    if ([_type isEqualToString:@"niaoji"]){
        if ([peripheral.name isEqualToString:@"NOVAUR_LE"]) {
            [self connet:peripheral];
        }
    }
}

- (void)connet:(CBPeripheral*)peripheral{
    [manager stopScan];
    [manager connectPeripheral:peripheral options:nil];
    NSLog(@"连接外设:%@",peripheral.description);
    [self postBlueChange:@"设备连接中"];
    self.peripheral = peripheral;
}

// 连接到外设后
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"已经连接到:%@", peripheral.description);
    [self postBlueChange:@"已连接"];
    peripheral.delegate = self;
    [central stopScan];
    [peripheral discoverServices:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        NSLog(@"搜索服务%@时发生错误:%@", peripheral.name, [error localizedDescription]);
        return;
    }
    for (CBService *service in peripheral.services) {
        //发现服务   kCharacteristicWriteUUID
//        if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]) {
            [peripheral discoverCharacteristics:nil forService:service];
//            break;
//        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@"搜索特征%@时发生错误:%@", service.UUID, [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"特征:%@",characteristic.UUID.UUIDString);
        
        //发现特征
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF1"]]) {
            _writeCharacteristic = characteristic;
            NSLog(@"_writeCharacteristic:%@",_writeCharacteristic.UUID);
            [[NSNotificationCenter defaultCenter] postNotificationName:WriteToBlue object:nil];
        }
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFF4"]]) {
            NSLog(@"监听特征:%@",characteristic.UUID);//监听特征
            [self.peripheral readValueForCharacteristic:characteristic];
            [self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
            _isConnected = YES;
            
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error){
        [delegate didGetDataForString:[NSString stringWithFormat:@"更新特征值%@时发生错误:%@", characteristic.UUID, [error localizedDescription]] Code:@"0"];
        NSLog(@"更新特征值%@时发生错误:%@", characteristic.UUID, [error localizedDescription]);
        [delegate didGetDataForString:@"" Code:@"0"];
        return;
    }
    NSString*value = [NSString stringWithFormat:@"%@",characteristic.value];
    
    NSMutableString*macString = [[NSMutableString alloc]init];
    
    [macString appendString:[[value substringWithRange:NSMakeRange(16,2)]uppercaseString]];
    
    [macString appendString:@":"];
    
    [macString appendString:[[value substringWithRange:NSMakeRange(14,2)]uppercaseString]];
    
    [macString appendString:@":"];
    
    [macString appendString:[[value substringWithRange:NSMakeRange(12,2)]uppercaseString]];
    
    [macString appendString:@":"];
    
    [macString appendString:[[value substringWithRange:NSMakeRange(5,2)]uppercaseString]];
    
    [macString appendString:@":"];
    
    [macString appendString:[[value substringWithRange:NSMakeRange(3,2)]uppercaseString]];
    
    [macString appendString:@":"];
    
    [macString appendString:[[value substringWithRange:NSMakeRange(1,2)]uppercaseString]];
    
    NSLog(@"MAC地址是macString:%@",macString);
    
    // 收到数据
    NSData *data = characteristic.value;
    NSString *hexStr = [self hexStrWithData:data];
    
    if ([_type isEqualToString:@"niaoji"]) {
        NSLog(@"get bluetouch %@",hexStr);
        if (indexOfniaoji == 0) {
            dataniaoji = hexStr;
        }
        if (indexOfniaoji == 1) {
            dataniaoji = [NSString stringWithFormat:@"%@%@",dataniaoji,hexStr];
        }
        if (indexOfniaoji == 2) {
            dataniaoji = [NSString stringWithFormat:@"%@%@",dataniaoji,hexStr];
            [delegate didGetDataForString:[self niaojice:dataniaoji] Code:@"1"];
            indexOfniaoji = 0;
        }
        indexOfniaoji ++;
        
    }else if ([_type isEqualToString:@"xueya"]){
        bloodPressure(hexStr, peripheral.name, characteristic.value);
        
    }else if([_type isEqualToString:@"xuetang"]){
        [delegate didGetDataForString:[self xuetangRex:hexStr] Code:@"1"];
    }else if([_type isEqualToString:@"tizhong"]){
        [delegate didGetDataForString:[self WeightData:hexStr] Code:@"1"];
    }else if([_type isEqualToString:@"xueyang"]){
        [delegate didGetDataForString:[self xueyang:hexStr data:characteristic.value] Code:@"1"];
    }else if([_type isEqualToString:@"tiwen"]) {
        [delegate didGetDataForString:[self temperatureData:hexStr data:characteristic.value] Code:@"1"];
    }
    
    NSLog(@"%@ value is :%@",characteristic.UUID,hexStr);
}

#pragma mark - CBCentralManager Delegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    NSString * state = nil;
    if (@available(iOS 10.0, *)) {
        switch ([central state]){
            case CBManagerStateUnsupported:
                state = @"StateUnsupported";
                break;
            case CBManagerStateUnauthorized:
                state = @"StateUnauthorized";
                break;
            case CBManagerStatePoweredOff:
                state = @"PoweredOff";
                [self postBlueChange:@"蓝牙未打开"];
                break;
            case CBManagerStatePoweredOn:
                [manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerRestoredStateScanOptionsKey:@(YES)}];
                state = @"PoweredOn";
                [self postBlueChange:@"蓝牙已打开"];
                break;
            case CBManagerStateUnknown:
                state = @"unknown";
                break;
            default:
                break;
        }
    }else{
        switch ([central state]){
            case CBCentralManagerStateUnsupported:
                state = @"StateUnsupported";
                
                break;
            case CBCentralManagerStateUnauthorized:
                state = @"StateUnauthorized";
                break;
            case CBCentralManagerStatePoweredOff:
                state = @"PoweredOff";
                [self postBlueChange:@"蓝牙未打开"];
                break;
            case CBCentralManagerStatePoweredOn:
                [manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerRestoredStateScanOptionsKey:@(YES)}];
                [self postBlueChange:@"蓝牙已打开"];
                state = @"PoweredOn";
                break;
            case CBCentralManagerStateUnknown:
                state = @"unknown";
                break;
            default:
                break;
        }
    }
    
    NSLog(@"手机状态:%@", state);
}



// 连接失败后
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接外设%@失败",peripheral);
    [delegate didGetDataForString:[NSString stringWithFormat:@"连接外设%@失败",peripheral] Code:@"0"];
}

// 断开外设
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"与%@断开连接",peripheral);
}

- (void)postBlueChange:(NSString*)state{
    [[NSNotificationCenter defaultCenter] postNotificationName:BlueStateChage object:@{@"state":state}];
}

#pragma mark - NSData and NSString
    
- (NSString*) temperatureData:(NSString *)hexStr data:(NSData *)data {
        Byte *bytes = (Byte *)[data bytes];
        NSString *b;
        NSString *tempStr;
        if (hexStr.length>2) {
            b = [hexStr substringWithRange:NSMakeRange(0, 2)];
        }
        if ([b isEqualToString:@"5e"]){
            if (hexStr.length >20) {
                NSString *byStr = [NSString stringWithFormat:@"%s",bytes];
                tempStr = [byStr substringWithRange:NSMakeRange(5, 4)];
            }
            
        }else{
            NSString *tempStr;
            // 体重&&体温
            NSRange range =  NSMakeRange(10, 4);
            NSString *realStr = [hexStr substringWithRange:range];
            NSInteger i = strtoul([realStr UTF8String], 0, 16);
            double temp = i/10.0;
            tempStr = [NSString stringWithFormat:@"%.1f",temp];
            
        }
        
    
            
    return [NSString stringWithFormat:@"%@",tempStr];
}

- (NSData*)dataWithHexstring:(NSString *)hexstring{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for(idx = 0; idx + 2 <= hexstring.length; idx += 2){
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [hexstring substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

- (NSString *)hexStrWithData:(NSData *)data {
    NSString *hexStr=@"";
    Byte *bytes = (Byte *)[data bytes];
    
    for(int i=0;i<data.length;i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; //16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
    
#pragma mark -  数据解析
    
    
- (NSString*)xueyang:(NSString*)hexStr data:(NSData*)data{
    //血氧
    NSInteger  readSize = hexStr.length;
    
    Byte * testByte = (Byte *)[data bytes]; //testByte 是字节数组
    
    if (readSize <= 0) {
        
        NSLog(@"数据为空");
        
        
    } else if (readSize < 9) {
        NSLog(@"BTThread Data is Short");
        
        
    } else if (((testByte[0] & 0xff) != 0x01)) {
        
        NSLog(@"BTThread Error Data Packet Header");
        
        
    } else if ((testByte[6] & 0xff & 0x7F) == 0) {
        
        NSLog(@"Error 6byte:");
        
        
    } else if ((testByte[5] & 0xff & 0x7F) == 0) {
        
        NSLog(@"Error 5byte:");
        
        
    } else {
        // 血氧饱和度
        int baohedu = (testByte[6] & 0x7F & 0xFF);
        // 脉率
        int mailv = (testByte[5] & 0x7F & 0xFF);
        
        NSString *persentage = [[NSString stringWithFormat:@"%d",baohedu] stringByAppendingString:@"%"];
        
        NSString *result =  [NSString stringWithFormat:@"%@/%d",persentage,mailv];

        return [NSString stringWithFormat:@"%@",result] ;
    }
    return  @"";
}
    
- (NSString*)WeightData:(NSString *)hexStr{
        
        NSRange range =  NSMakeRange(10, 4);
        NSString *realStr = [hexStr substringWithRange:range];
        NSInteger i = strtoul([realStr UTF8String], 0, 16);
        double temp = i/10.0;
        NSString *tizhongStr = [NSString stringWithFormat:@"%.1f",temp];
    return [NSString stringWithFormat:@"%@",tizhongStr];
}
    
-(NSString*)niaojice:(NSString*)hexStr{
    if (hexStr.length < 80) {
        return @"";
    }
    // Year
    NSRange rangeyear1 = NSMakeRange(6*2 , 2);
    NSString *year1str = [hexStr substringWithRange:rangeyear1];
    NSInteger year1 = strtoul([year1str UTF8String], 0, 16);
    NSRange rangeyear2 = NSMakeRange(7*2 , 1*2);
    NSString *year2str = [hexStr substringWithRange:rangeyear2];
    NSInteger year2 = strtoul([year2str UTF8String], 0, 16);
    NSInteger year = year1 * 100 + year2;
    
    // Month
    NSRange rangemonth = NSMakeRange(8*2 , 1*2);
    NSString *monthstr = [hexStr substringWithRange:rangemonth];
    NSInteger month = strtoul([monthstr UTF8String], 0, 16);
    
    // Day
    NSRange rangeday = NSMakeRange(9*2 , 1*2);
    NSString *daystr = [hexStr substringWithRange:rangeday];
    NSInteger day = strtoul([daystr UTF8String], 0, 16);
    
    // Hour
    NSRange hourday = NSMakeRange(10*2 , 1*2);
    NSString *hourstr = [hexStr substringWithRange:hourday];
    NSInteger hour = strtoul([hourstr UTF8String], 0, 16);
    
    // Minutes
    NSRange rangeminute = NSMakeRange(11*2 , 1*2);
    NSString *minutestr = [hexStr substringWithRange:rangeminute];
    NSInteger minute = strtoul([minutestr UTF8String], 0, 16);
    
    // seconds
    NSRange rangesecond = NSMakeRange(12*2 , 1*2);
    NSString *rangesecondstr = [hexStr substringWithRange:rangesecond];
    NSInteger second = strtoul([rangesecondstr UTF8String], 0, 16);
    
    // project1 尿蛋白
    NSRange urorange = NSMakeRange(15*2 , 1*2);
    NSString *urostr = [hexStr substringWithRange:urorange];
    NSInteger uro = strtoul([urostr UTF8String], 0, 16);
    
    // project2 潜血
    NSRange bldrange = NSMakeRange(17*2 , 1*2);
    NSString *bldstr = [hexStr substringWithRange:bldrange];
    NSInteger bld = strtoul([bldstr UTF8String], 0, 16);
    
    // project3 胆红素
    NSRange bilrange = NSMakeRange(19*2 , 1*2);
    NSString *bilstr = [hexStr substringWithRange:bilrange];
    NSInteger bil = strtoul([bilstr UTF8String], 0, 16);
    
    // project4 胴体
    NSRange ketrange = NSMakeRange(21*2 , 1*2);
    NSString *ketstr = [hexStr substringWithRange:ketrange];
    NSInteger ket = strtoul([ketstr UTF8String], 0, 16);
    
    // project 9 白细胞
    NSRange leurange = NSMakeRange(23*2 , 1*2);
    NSString *leustr = [hexStr substringWithRange:leurange];
    NSInteger leu = strtoul([leustr UTF8String], 0, 16);
    
    // project 5 葡萄糖
    NSRange glurange = NSMakeRange(25*2 , 1*2);
    NSString *glustr = [hexStr substringWithRange:glurange];
    NSInteger glu = strtoul([glustr UTF8String], 0, 16);
    
    // project 6 蛋白质
    NSRange prorange = NSMakeRange(27*2 , 1*2);
    NSString *prostr = [hexStr substringWithRange:prorange];
    NSInteger pro = strtoul([prostr UTF8String], 0, 16);
    
    // project 7 酸碱度
    NSRange phrange = NSMakeRange(29*2 , 1*2);
    NSString *phstr = [hexStr substringWithRange:phrange];
    NSInteger ph = strtoul([phstr UTF8String], 0, 16);
    
    // project 8 亚硝酸盐
    NSRange nitrange = NSMakeRange(31*2 , 1*2);
    NSString *nitstr = [hexStr substringWithRange:nitrange];
    NSInteger nit = strtoul([nitstr UTF8String], 0, 16);
    
    // project 10 比重
    NSRange sgrange = NSMakeRange(33*2 , 1*2);
    NSString *sgstr = [hexStr substringWithRange:sgrange];
    NSInteger sg = strtoul([sgstr UTF8String], 0, 16);
    
    // project 11 维生素C
    NSRange vcrange = NSMakeRange(35*2 , 1*2);
    NSString *vcstr = [hexStr substringWithRange:vcrange];
    NSInteger vc = strtoul([vcstr UTF8String], 0, 16);
    
    //    NSLog(@"%@",[NSString stringWithFormat:@"%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/%zd/",year,month,day,hour,minute,second,uro,bld,bil,ket,leu,glu,pro,ph,nit,sg,vc]);
    switch (uro) {
        case 0:
        urostr = @"-";
        break;
        case 1:
        urostr = @"+-";
        break;
        case 2:
        urostr = @"1+";
        break;
        case 3:
        urostr = @"2+";
        break;
        case 4:
        urostr = @"3+";
        break;
        default:
        break;
    }
    switch (bld) {
        case 0:
        bldstr = @"-";
        break;
        case 1:
        bldstr = @"+-";
        break;
        case 2:
        bldstr = @"1+";
        break;
        case 3:
        bldstr = @"2+";
        break;
        case 4:
        bldstr = @"3+";
        break;
        default:
        break;
    }
    switch (bil) {
        case 0:
        bilstr = @"-";
        break;
        case 1:
        bilstr = @"1-";
        break;
        case 2:
        bilstr = @"2+";
        break;
        case 3:
        bilstr = @"3+";
        break;
        case 4:
        bilstr = @"3+";
        break;
        default:
        break;
    }
    switch (ket) {
        case 0:
        ketstr = @"-";
        break;
        case 1:
        ketstr = @"+-";
        break;
        case 2:
        ketstr = @"1+";
        break;
        case 3:
        ketstr = @"2+";
        break;
        case 4:
        ketstr = @"3+";
        break;
        default:
        break;
    }
    switch (leu) {
        case 0:
        leustr = @"-";
        break;
        case 1:
        leustr = @"+-";
        break;
        case 2:
        leustr = @"1+";
        break;
        case 3:
        leustr = @"2+";
        break;
        case 4:
        leustr = @"3+";
        break;
        default:
        break;
    }
    switch (glu) {
        case 0:
        glustr = @"-";
        break;
        case 1:
        glustr = @"+-";
        break;
        case 2:
        glustr = @"1+";
        break;
        case 3:
        glustr = @"2+";
        break;
        case 4:
        glustr = @"3+";
        break;
        default:
        break;
    }
    switch (pro) {
        case 0:
        prostr = @"-";
        break;
        case 1:
        prostr = @"+-";
        break;
        case 2:
        prostr = @"1+";
        break;
        case 3:
        prostr = @"2+";
        break;
        case 4:
        prostr = @"3+";
        break;
        default:
        break;
    }
    switch (ph) {
        case 0:
        phstr = @"5.0";
        break;
        case 1:
        prostr = @"5.5";
        break;
        case 2:
        prostr = @"6.0";
        break;
        case 3:
        prostr = @"6.5";
        break;
        case 4:
        prostr = @"7.0";
        break;
        case 5:
        prostr = @"7.5";
        break;
        case 6:
        prostr = @"8.0";
        break;
        case 7:
        prostr = @"8.5";
        break;
        case 8:
        prostr = @"9.0";
        break;
        default:
        break;
    }
    switch (nit) {
        case 0:
        nitstr = @"-";
        break;
        case 1:
        nitstr = @"+";
        break;
        default:
        break;
    }
    switch (sg) {
        case 0:
        sgstr = @"1.000";
        break;
        case 1:
        sgstr = @"1.005";
        break;
        case 2:
        sgstr = @"1.010";
        break;
        case 3:
        sgstr = @"1.015";
        break;
        case 4:
        sgstr = @"1.020";
        break;
        case 5:
        sgstr = @"1.025";
        break;
        case 6:
        sgstr = @"1.030";
        break;
        default:
        break;
    }
    switch (vc) {
        case 0:
        vcstr = @"-";
        break;
        case 1:
        vcstr = @"1+";
        break;
        case 2:
        vcstr = @"2+";
        break;
        case 3:
        vcstr = @"3+";
        break;
        default:
        break;
    }
    
    return [NSString stringWithFormat:@"%zd/%zd/%zd/%zd/%zd/%zd/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%zd/",year,month,day,hour,minute,second,urostr,bldstr,bilstr,ketstr,leustr,glustr,prostr,phstr,nitstr,sgstr,vcstr];
}
    
- (NSString*)xuetangRex:(NSString*)hexStr{
    NSRange rangeTang =  NSMakeRange(24, 2);
    NSString *realStrTang = [hexStr substringWithRange:rangeTang];
    NSInteger iTang = strtoul([realStrTang UTF8String], 0, 16);
    double tempTang = iTang/10.0;
    NSString *tempStrTang = [NSString stringWithFormat:@"%.1f",tempTang];
    return tempStrTang;
}
    
    void bloodPressure(NSString *hexStr ,NSString *peripheralName,NSData *data){
        if ([peripheralName isEqualToString:@"BPM-188"]) {
            if (hexStr.length==14) { //压力值
                NSRange range =  NSMakeRange(10, 2);
                NSString *yaliStr = [hexStr substringWithRange:range];
                NSInteger i = strtoul([yaliStr UTF8String], 0, 16);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"yali" object:[NSString stringWithFormat:@"%zd",i]];
            }else if (hexStr.length==34) {
                NSRange rangeGao = NSMakeRange(12, 2);
                NSString *gao = [hexStr substringWithRange:rangeGao];
                NSInteger gaoZhi = strtoul([gao UTF8String], 0, 16);
                NSLog(@"高压==%ld",(long)gaoZhi);
                //低压
                NSRange rangDi = NSMakeRange(16, 2);
                NSString *di = [hexStr substringWithRange:rangDi];
                NSInteger diZhi = strtoul([di UTF8String], 0, 16);
                NSLog(@"低压==%ld",(long)diZhi);
                //心率
                NSRange rangXinLv = NSMakeRange(24, 2);
                NSString *xinlv = [hexStr substringWithRange:rangXinLv];
                NSInteger xinlvZhi = strtoul([xinlv UTF8String], 0, 16);
                NSLog(@"心率==%ld",(long)xinlvZhi);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"xueyaData" object:[NSString stringWithFormat:@"%zd/%zd/%zd",gaoZhi,diZhi,xinlvZhi]];
            }
        }else if([peripheralName isEqualToString:@"H.HOME BP"]){
            if (hexStr.length==14) { //压力值
                NSRange range =  NSMakeRange(10, 2);
                NSString *yaliStr = [hexStr substringWithRange:range];
                NSInteger i = strtoul([yaliStr UTF8String], 0, 16);
                if (i >0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"yali" object:[NSString stringWithFormat:@"%zd",i]];
                }
            }else if (hexStr.length==36){//电量值
            
            }else if (hexStr.length==34){//测量结果
                
                NSRange rangeSucess = NSMakeRange(8, 2);
                NSString *sucessOrNot = [hexStr substringWithRange:rangeSucess];
                if ([sucessOrNot isEqualToString:@"1c"]) {
                    //高压
                    NSRange rangeGao = NSMakeRange(10, 4);
                    NSString *gao = [hexStr substringWithRange:rangeGao];
                    NSInteger gaoZhi = strtoul([gao UTF8String], 0, 16);
                    if (gaoZhi == 255) {
                        gaoZhi = 0;
                    }
                    //低压
                    NSRange rangDi = NSMakeRange(14, 4);
                    NSString *di = [hexStr substringWithRange:rangDi];
                    
                    NSInteger diZhi = strtoul([di UTF8String], 0, 16);
                    
                    if (diZhi == 255) {
                        diZhi = 0;
                    }
                    //心率
                    NSRange rangXinLv = NSMakeRange(22, 4);
                    NSString *xinlv = [hexStr substringWithRange:rangXinLv];
                    
                    NSInteger xinlvZhi = strtoul([xinlv UTF8String], 0, 16);
                    
                    if (xinlvZhi == 255) {
                        xinlvZhi = 0;
                    }
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"xueyaData" object:[NSString stringWithFormat:@"%zd/%zd/%zd",gaoZhi,diZhi,xinlvZhi]];
  
                }else{
                    NSRange rangError = NSMakeRange(24, 2);
                    NSString *ErrorCode = [hexStr substringWithRange:rangError];
                    
                    if ([ErrorCode isEqualToString:@"04"]) {
                        
                        NSLog(@"腕带过松或漏气");
                    }else if ([ErrorCode isEqualToString:@"01"]){
                        NSLog(@"传感器信号异常");
                    }else if ([ErrorCode isEqualToString:@"02"]){
                        
                        NSLog(@"测量不出结果");
                    }else if ([ErrorCode isEqualToString:@"03"]){
                        
                        NSLog(@"测量结果异常");
                    }else if ([ErrorCode isEqualToString:@"05"]){
                        
                        NSLog(@"腕带过紧或气路堵塞");
                    }else if ([ErrorCode isEqualToString:@"06"]){
                        NSLog(@"测量中压力干扰严重");
                    }else if ([ErrorCode isEqualToString:@"07"]){
                        NSLog(@"压力超300");
                    }
                }
                
            }
        }else if([peripheralName isEqualToString:@"Yuwell BloodPressure"]){
            NSLog(@"string is %@",hexStr);
            if (hexStr.length < 35) {
                return;
            }
            //    1 3 14  文档不对 1 -> 2-3 3 -> 5-6 14 -> 27-28
            NSRange rangeGao = NSMakeRange(2 , 2);
            NSString *gao = [hexStr substringWithRange:rangeGao];
            
            NSInteger gaoZhi = strtoul([gao UTF8String], 0, 16);
            
            NSLog(@"高压==%ld",(long)gaoZhi);
            
            //低压
            NSRange rangDi = NSMakeRange(6, 2);
            NSString *di = [hexStr substringWithRange:rangDi];
            
            NSInteger diZhi = strtoul([di UTF8String], 0, 16);
            NSString *diya = [NSString stringWithFormat:@"%zd",diZhi];
            if (diZhi == 255) {
                diya = @"-";
            }
            NSLog(@"低压==%ld",(long)diZhi);
            
            //心率
            NSRange rangXinLv = NSMakeRange(28, 2);
            NSString *xinlv = [hexStr substringWithRange:rangXinLv];
            
            NSInteger xinlvZhi = strtoul([xinlv UTF8String], 0, 16);
            NSString *xinlvv = [NSString stringWithFormat:@"%zd",xinlvZhi];
            if (xinlvZhi == 255) {
                xinlvv = @"-";
            }
            NSLog(@"心率==%ld",(long)xinlvZhi);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"xueyaData" object:[NSString stringWithFormat:@"%zd/%@/%@",gaoZhi,diya,xinlvv]];
        }
        
        
    }


@end

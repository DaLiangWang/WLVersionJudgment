# WLVersionJudgment
版本更新对比分类
使用方法

    NSString *min = @"2.8.0";
    NSString *tishi = @"3.00.0.3";
    if (min.contrastVersion) {
        NSLog(@"需要更新");
    }
    
    [NSString minVersion:min promptVersion:tishi normalBlock:^(NSString * _Nonnull version) {
        NSLog(@"不提示更新");
    } hotBlock:^(NSString * _Nonnull version) {
        NSLog(@"re更新");
    } promptBlock:^(NSString * _Nonnull version) {
        NSLog(@"提示更新");
    } mandatoryBlock:^(NSString * _Nonnull version) {
        NSLog(@"强制更新");
    }];

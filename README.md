# SActivityIndicatorView

    CGRect SActivityViewRect=CGRectMake(0, 50, 320, 20);
    SActivityView *ActivityView=[[SActivityView alloc] initWithFrame:SActivityViewRect];
    ActivityView.numberOfCircles = 5;
    ActivityView.radius = 8;
    ActivityView.internalSpacing = 5;
    [ActivityView startAnimating];
    [self.view addSubview:ActivityView];

//
//  ViewController.m
//  Demo8
//
//  Created by vfa on 8/18/22.
//

#import "ViewController.h"
static NSString *TableViewCellIdentifier = @"MyCell";
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayItems;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayItems = [[NSMutableArray alloc] initWithObjects:@"Item 1",@"Item 2",@"Item 3",@"Item 4",@"Item 5",@"Item 6",@"Item 7",@"Item 8", nil];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

// use this method if want to devide into section
// - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//     if([tableView isEqual: self.tableView]){
//         return 3;
//     }
//     return 0;
// }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = nil;
    
    if([tableView isEqual:self.tableView]){
        cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:self.arrayItems[indexPath.row],(long) indexPath.section,(long) indexPath.row];
        NSLog(@"%ld",(long)indexPath.row);
        if((NSInteger)indexPath.row % 2 != 0){cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            
        }
        else{
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            
            [button setTitle:@"Expand" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(expandTap) forControlEvents:UIControlEventTouchUpInside];
            
            [button sizeToFit];
            
            if(cell.accessoryType != UITableViewCellAccessoryDetailDisclosureButton &&cell.accessoryView!=button)
            {cell.accessoryView = button;}
                
            
        }
        
    }
    
    return cell;
}

-(void) expandTap{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Expand Button Tap" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void) tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:(nonnull NSIndexPath *)indexPath{
   
    UITableViewCell *owner = [tableView cellForRowAtIndexPath:indexPath];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:owner.textLabel.text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        [self.arrayItems removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

-(UILabel *) newLabelWithTitle:(NSString *) title{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = title;
    label.backgroundColor = UIColor.clearColor;
    [label sizeToFit];
    return  label;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        
    NSString *title = [NSString stringWithFormat:@"%s%li%s","Section ",section," Header"];
        return [self newLabelWithTitle:title];

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSString *title = [NSString stringWithFormat:@"%s%li%s","Section ",section," Footer"];
    return [self newLabelWithTitle:title];
    
}
@end

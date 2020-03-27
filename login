import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.RowSorter;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;
 
public class login {
	
	static ArrayList<Student> as = new ArrayList<Student>(); //重要！ 保存了当前处理的所有记录！
 
	private JFrame frame;
	JTable table;
 
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					login window = new login();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
 
	/**
	 * Create the application.
	 */
	public login() {
		initialize();
	}
 
	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		load();
		frame = new JFrame();
		frame.getContentPane().setBackground(new Color(153, 204, 153));
		frame.setBounds(400, 400, 525, 447);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		// 关闭程序之前将list 里面保存的所有记录写出文件！
		frame.addWindowListener( new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				try {
				
					File stu_csv = new File("F://stu.csv");
					if(stu_csv.exists())    //必须删除原有文件，保持文件没有冗余！
						stu_csv.delete();
					stu_csv.createNewFile();
					BufferedWriter bfw = new BufferedWriter(new FileWriter(stu_csv,true));//true 表示文件是追加模式
					//bfw.newLine();
					for (Student stu : as) {
						bfw.write(stu.id+","+stu.name+","+stu.kecheng+","+stu.score+"\r\n");
					}
					bfw.close();
					
				} catch (IOException es) {
					// TODO Auto-generated catch block
					es.printStackTrace();
				}
				System.exit(0);
			};
		}
			
		);
		//Image img=Toolkit.getDefaultToolkit().getImage("F:\\wancy.jpg");
		ImageIcon img = new ImageIcon("F:\\wancy.jpg");
		
		JMenuBar menuBar = new JMenuBar();
		frame.setJMenuBar(menuBar);
		
		JMenu mnNewMenu = new JMenu("操作");
		menuBar.add(mnNewMenu);
		
		JMenuItem add_menuItem = new JMenuItem("添加");
		
		mnNewMenu.add(add_menuItem);
		add_menuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new addScore(as);
			}
		});
		
		JMenuItem del_menuItem = new JMenuItem("删除");
		del_menuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new delet(as);
			}
		});
		mnNewMenu.add(del_menuItem);
		
		JMenuItem change_menuItem = new JMenuItem("修改");
		change_menuItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				new modify(as);
			}
		});
		mnNewMenu.add(change_menuItem);
		
		JMenuItem query_menuItem = new JMenuItem("查询");
		mnNewMenu.add(query_menuItem);
		
		JMenuItem update_menuItem = new JMenuItem("更新");
		mnNewMenu.add(update_menuItem);
		//显示界面
				String col[]={"学号","姓名","签到时间","疫情情况"};
				final DefaultTableModel tableModel = new DefaultTableModel(col, 0);
			  JTable table = new JTable(tableModel);
			  table.setEnabled(false);
				JScrollPane pane = new JScrollPane(table); //设置table不可编辑
				JTableHeader tableH;
				table.setBackground(new Color(144,238,144));
				table.setForeground(new Color(100,100,100)) ;
				table.setGridColor(new Color(105 ,105, 105));
				tableH = table.getTableHeader();
			    //设置表头的背景色
			    tableH.setBackground(new Color(200, 200, 200));
			    //设置表头的文字颜色
			  
			    tableH.setForeground(new Color(0,0,205));
				for (Student student : as) {
					Object [] data ={student.id,student.name,student.kecheng,student.score};
					tableModel.addRow(data);
				}
				tableModel.fireTableDataChanged();
				 RowSorter<TableModel> sorter = new TableRowSorter<TableModel>(tableModel); //可以排序
				 table.setRowSorter(sorter);
				 frame.getContentPane().add(pane, BorderLayout.CENTER);
				
		
		update_menuItem.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				
				tableModel.setRowCount(0); // 之前的table一定要清零！
				//ArrayList<Student> asss = new display().as;
				//load();
				for (Student student : as) {
					Object [] data1 ={student.id,student.name,student.kecheng,student.score};
					System.out.println(student.id+student.name+student.kecheng+student.score);
					tableModel.addRow(data1);
				}
				//tableModel.fireTableDataChanged(); // 更新table；
				
				//System.out.println("hello");
				
				 
			}
		});
		
		
	}
	void load(){
		try { 
	           File csv = new File("F://stu.csv"); // CSV文件
 
	           BufferedReader br = new BufferedReader(new FileReader(csv));
 
	           // 读取直到最后一行 
	           String line = ""; 
	           while ((line = br.readLine()) != null) { 
	               // 把一行数据分割成多个字段 
	               StringTokenizer st = new StringTokenizer(line, ",");
	               Student sst = new Student(st.nextToken(),st.nextToken(),st.nextToken(),st.nextToken());
	               as.add(sst);
	               System.out.println(); 
	           } 
	           br.close();
	           
 
	       } catch (FileNotFoundException e) { 
	           // 捕获File对象生成时的异常 
	           e.printStackTrace(); 
	       } catch (IOException e) { 
	           // 捕获BufferedReader对象关闭时的异常 
	           e.printStackTrace(); 
	       } 
	}
	
}

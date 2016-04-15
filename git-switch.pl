#!/usr/bin/perl
#--------------------------------------#
# git-switch
# 
# https://github.com/jpickell/git-switch
# https://gitlab.com/jpickell/git-switch
#
#--------------------------------------#

#
# Repositories are configured below
# username:repository URL
# This should be moved into its own config file

$c=1; 
$found=0;
chomp($git=`which git`);

# username:repo url
@repos=qw{
jkp:gitlab.vxrs.com
jpickell:gitlab.com
jpickell:github.com
pickellj:github.wwt.com
};

sub dstamp(){
   chomp($dt=`date`);
   $dline="Last Updated: $dt\n";
   if(-e "README.md"){
       @file=`cat README.md`;
    }else{
	@file="";
    }
   open(FILE, ">README.md")||die "Can't write to README.md, $!\n"; 
   foreach $f(@file){
	if ($f =~ /^Last Updated/){
		$f=$dline;
		$found=1;
	   }
	   print FILE $f;
	}
	if ($found == 0){ print FILE $dline; };
   close FILE;
}

sub menu(){
   foreach $r(@repos){
	chomp $r;
	($user,$rc)=split(/:/,$r);
	print ("[$c] $rc");

	if($rc eq $remote){
		print(" *\n");
	}else{
		print("\n");
	}
	$c++;
   }

 print ("\nChoose new repository: ");
 chomp($ans=<>);$ans=$ans-1;
 ($ruser,$rnew)=split(/:/, $repos[$ans]);
 return $ruser,$rnew;
}

sub init(){
 print("\n$git remote set-url origin git\@$rnew:$ruser/$project\n");
 system("$git remote set-url origin git\@$rnew:$ruser/$project");
 dstamp;
}

sub current(){
 @repo=split(/[\@:\/+]/, `$git config --get remote.origin.url`);

 if ($repo[0] == "git"){
	$remote  = $repo[1];
	$user    = $repo[2];
	$project = $repo[3];
 }

 if ($repo[0] =~  m/http/){
	$remote  = $repo[3];
	$user    = $repo[4];
	$project = $repo[5];
 }
 return $project;
}

if ( ! -e $git){exit;}
if ( ! -d ".git"){
	@PWD=split(/\//,$ENV{"PWD"});
	$project=pop @PWD;	
	print("This directory has not been initialized.  Initialize? (y|n) ");
	chomp($ANS=<>);
	if($ANS eq "y"){
		print("$git init\n");
		system("$git init");
		menu;
		print("$git remote add origin git\@$rnew:$ruser/$project.git\n");
		system("$git remote add origin git\@$rnew:$ruser/$project.git\n");
		dstamp;
		exit;
	   }else{
        	exit;
	   }
	}else{
	current;
	menu;
	init;
}

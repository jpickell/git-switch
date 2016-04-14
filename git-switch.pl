#!/usr/bin/perl

# Need to add a .active function so that
# you can trigger a push even with a clean
# repo
#
# Repositories are configured below
# username:repository URL
# This should be moved into its own config file

$c=1; 

@repos=qw{
jkp:gitlab.vxrs.com
jpickell:gitlab.com
jpickell:github.com
pickellj:github.wwt.com
};


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
 print("\ngit remote set-url origin git\@$rnew:$ruser/$project\n");
 system("git remote set-url origin git\@$rnew:$ruser/$project");
}

sub current(){
 @repo=split(/[\@:\/+]/, `git config --get remote.origin.url`);

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

if ( ! -e "/usr/bin/git"){exit;}
if ( ! -d ".git"){
	$user=$ENV{"USER"};
	@PWD=split(/\//,$ENV{"PWD"});
	$project=pop @PWD;	
	print("This directory has not been initialized.  Initialize? (y|n) ");
	chomp($ANS=<>);
	if($ANS eq "y"){
		print("git init\n");
		system("git init");
		menu;
		print("git remote add origin git\@$rnew:$user/$project.git\n");
		system("git remote add origin git\@$rnew:$user/$project.git\n");
		exit;
	   }else{
        	exit;
	   }
	}else{
	current;
	menu;
	init;
}

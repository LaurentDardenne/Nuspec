﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NugetSchema
{
    // 
    // Ce code source a été automatiquement généré par xsd, Version=4.0.30319.33440.
    // 


    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [Serializable()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    [System.Xml.Serialization.XmlRootAttribute(Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd", IsNullable = false)]
    public partial class package
    {

        private packageMetadata metadataField;

        private packageFile[] filesField;

        /// <remarks/>
        public packageMetadata metadata
        {
            get
            {
                return this.metadataField;
            }
            set
            {
                this.metadataField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayAttribute(IsNullable = true)]
        [System.Xml.Serialization.XmlArrayItemAttribute("file", IsNullable = false)]
        public packageFile[] files
        {
            get
            {
                return this.filesField;
            }
            set
            {
                this.filesField = value;
            }
        }
        
        /// <summary>
        /// Make sure the list of files  has any content
        /// </summary>
        public bool ShouldSerializefiles()
        {
            return !(filesField == null || filesField.Length <= 0);
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [Serializable()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadata
    {

        private string idField;

        private string versionField;

        private string titleField;

        private string authorsField;

        private string ownersField;

        private string licenseUrlField;

        private string projectUrlField;

        private string iconUrlField;

        private bool requireLicenseAcceptanceField;

        private bool requireLicenseAcceptanceFieldSpecified;

        private string descriptionField;

        private string summaryField;

        private string releaseNotesField;

        private string copyrightField;

        private string languageField;

        private string tagsField;

        private packageMetadataDependency[] dependenciesField;

        private packageMetadataFrameworkAssembly[] frameworkAssembliesField;

        private packageMetadataReference[] referencesField;

        public packageMetadata()
        {
            this.languageField = "en-US";
        }

        /// <remarks/>
        public string id
        {
            get
            {
                return this.idField;
            }
            set
            {
                this.idField = value;
            }
        }

        /// <remarks/>
        public string version
        {
            get
            {
                return this.versionField;
            }
            set
            {
                this.versionField = value;
            }
        }

        /// <remarks/>
        public string title
        {
            get
            {
                return this.titleField;
            }
            set
            {
                this.titleField = value;
            }
        }

        /// <remarks/>
        public string authors
        {
            get
            {
                return this.authorsField;
            }
            set
            {
                this.authorsField = value;
            }
        }

        /// <remarks/>
        public string owners
        {
            get
            {
                return this.ownersField;
            }
            set
            {
                this.ownersField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(DataType = "anyURI")]
        public string licenseUrl
        {
            get
            {
                return this.licenseUrlField;
            }
            set
            {
                this.licenseUrlField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(DataType = "anyURI")]
        public string projectUrl
        {
            get
            {
                return this.projectUrlField;
            }
            set
            {
                this.projectUrlField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlElementAttribute(DataType = "anyURI")]
        public string iconUrl
        {
            get
            {
                return this.iconUrlField;
            }
            set
            {
                this.iconUrlField = value;
            }
        }

        /// <remarks/>
        public bool requireLicenseAcceptance
        {
            get
            {
                return this.requireLicenseAcceptanceField;
            }
            set
            {
                this.requireLicenseAcceptanceField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlIgnoreAttribute()]
        public bool requireLicenseAcceptanceSpecified
        {
            get
            {
                return this.requireLicenseAcceptanceFieldSpecified;
            }
            set
            {
                this.requireLicenseAcceptanceFieldSpecified = value;
            }
        }

        /// <remarks/>
        public string description
        {
            get
            {
                return this.descriptionField;
            }
            set
            {
                this.descriptionField = value;
            }
        }

        /// <remarks/>
        public string summary
        {
            get
            {
                return this.summaryField;
            }
            set
            {
                this.summaryField = value;
            }
        }

        /// <remarks/>
        public string releaseNotes
        {
            get
            {
                return this.releaseNotesField;
            }
            set
            {
                this.releaseNotesField = value;
            }
        }

        /// <remarks/>
        public string copyright
        {
            get
            {
                return this.copyrightField;
            }
            set
            {
                this.copyrightField = value;
            }
        }

        /// <remarks/>
        [System.ComponentModel.DefaultValueAttribute("en-US")]
        public string language
        {
            get
            {
                return this.languageField;
            }
            set
            {
                this.languageField = value;
            }
        }

        /// <remarks/>
        public string tags
        {
            get
            {
                return this.tagsField;
            }
            set
            {
                this.tagsField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayItemAttribute("dependency", IsNullable = false)]
        public packageMetadataDependency[] dependencies
        {
            get
            {
                return this.dependenciesField;
            }
            set
            {
                this.dependenciesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayItemAttribute("frameworkAssembly", IsNullable = false)]
        public packageMetadataFrameworkAssembly[] frameworkAssemblies
        {
            get
            {
                return this.frameworkAssembliesField;
            }
            set
            {
                this.frameworkAssembliesField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayItemAttribute("reference", IsNullable = false)]
        public packageMetadataReference[] references
        {
            get
            {
                return this.referencesField;
            }
            set
            {
                this.referencesField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [Serializable()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadataDependency
    {

        private string idField;

        private string versionField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string id
        {
            get
            {
                return this.idField;
            }
            set
            {
                this.idField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string version
        {
            get
            {
                return this.versionField;
            }
            set
            {
                this.versionField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [Serializable()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadataFrameworkAssembly
    {

        private string assemblyNameField;

        private string targetFrameworkField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string assemblyName
        {
            get
            {
                return this.assemblyNameField;
            }
            set
            {
                this.assemblyNameField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string targetFramework
        {
            get
            {
                return this.targetFrameworkField;
            }
            set
            {
                this.targetFrameworkField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [Serializable()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageMetadataReference
    {

        private string fileField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string file
        {
            get
            {
                return this.fileField;
            }
            set
            {
                this.fileField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.33440")]
    [Serializable()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true, Namespace = "http://schemas.microsoft.com/packaging/2011/08/nuspec.xsd")]
    public partial class packageFile
    {

        private string srcField;

        private string targetField;

        private string excludeField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string src
        {
            get
            {
                return this.srcField;
            }
            set
            {
                this.srcField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string target
        {
            get
            {
                return this.targetField;
            }
            set
            {
                this.targetField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string exclude
        {
            get
            {
                return this.excludeField;
            }
            set
            {
                this.excludeField = value;
            }
        }
    }
}
